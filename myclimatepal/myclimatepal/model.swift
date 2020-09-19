//
//  model.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import Combine
import Foundation
import Fuse

//let co2val = 70.0
//currentCo2State = co2val/co2max

final class Co2State: ObservableObject {
    // MARK: Co2
    @Published var currentCo2State: Double = 0
    @Published var co2max = 11.0
    @Published var co2HistoryData: [Double] = []//[8, 23, 54, 32, 12, 37, 7, 23, 43]

    var co2data: [String: Any]
    var listItems: [ListItem] = []
    var listItemsDict: [String: ListItem] = [:]
    @Published var addedItems: [Entry] = []

    init(currentCo2State: Double = 0.0) {
        self.currentCo2State = currentCo2State

        co2data = Co2State.readJSONFromFile(fileName: "Co2_data") as? [String: Any] ?? [:]
        for x in co2data {
            // i has no idea what is happening here but it works
            let category: String = (x.value as! [String: Any])["category"] as! String
            let CO2eqkg: NSNumber = (x.value as! [String: Any])["CO2eqkg"]! as! NSNumber
            listItems.append(ListItem(description: x.key, category: category, CO2eqkg: CO2eqkg.doubleValue, topCategory: "Food"))
        }

        listItems.append(ListItem(description: "Car", category: "Transport", CO2eqkg: 0.050, topCategory: "Transport"))
        listItems.append(ListItem(description: "Bus", category: "Transport", CO2eqkg: 0.068, topCategory: "Transport"))
        listItems.append(ListItem(description: "Train", category: "Transport", CO2eqkg: 0.014, topCategory: "Transport"))
        listItems.append(ListItem(description: "Plane", category: "Transport", CO2eqkg: 0.285, topCategory: "Transport"))
        listItems.append(ListItem(description: "Ship", category: "Transport", CO2eqkg: 0.245, topCategory: "Transport"))

        for item in listItems {
            listItemsDict[item.description] = item
        }

        let value = UserDefaults.standard.object(forKey: "addedItems") as? Data
        if value != nil {
            addedItems = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value!) as? [Entry] ?? []
        } else {
            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 32, dateAdded: Date().addingTimeInterval(-0*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 30, dateAdded: Date().addingTimeInterval(-1*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "Car", amount: 30, dateAdded: Date().addingTimeInterval(-1*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 20, dateAdded: Date().addingTimeInterval(-2*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "Car", amount: 10, dateAdded: Date().addingTimeInterval(-1*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 40, dateAdded: Date().addingTimeInterval(-3*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "Train", amount: 10, dateAdded: Date().addingTimeInterval(-1*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 50, dateAdded: Date().addingTimeInterval(-4*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "Plane", amount: 10, dateAdded: Date().addingTimeInterval(-1*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 25, dateAdded: Date().addingTimeInterval(-5*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 66, dateAdded: Date().addingTimeInterval(-6*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 12, dateAdded: Date().addingTimeInterval(-7*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 2, dateAdded: Date().addingTimeInterval(-8*24*60*60)))

            addedItems.append(Entry(category: "Food", type: "Garlic", amount: 44, dateAdded: Date().addingTimeInterval(-9*24*60*60)))
        }

        update()
    }

    func update() {
        saveEntries()
        updateCurrentCo2()
        co2HistoryData = getCo2PerDay()
    }

    func updateCurrentCo2() {
        var co2: Double = 0
        for item in addedItems {
            if Calendar.current.dateComponents([.day], from: item.dateAdded, to: Date()).day == 0 {
                co2 += listItemsDict[item.type]!.CO2eqkg * item.amount
            }
        }
        currentCo2State = co2
    }

    func getCo2PerDay(category: String = "", n_days: Int = 10) -> [Double] {
        var co2Stats: [Int: Double] = [:]
        for item in addedItems {
            let daysDiff = Calendar.current.dateComponents([.day], from: item.dateAdded, to: Date()).day ?? 0
            co2Stats[daysDiff] = listItemsDict[item.type]!.CO2eqkg * item.amount + (co2Stats[daysDiff] ?? 0)
        }
        var result: [Double] = []
        for i in 0..<n_days {
            result.append(co2Stats[n_days - i - 1] ?? 0)
        }
        return result
    }

    func saveEntries() {
        let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: addedItems, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: "addedItems")
    }

    func addEntry(item: ListItem, amount: Double) {
        let entry = Entry(category: item.category, type: item.description, amount: amount, dateAdded: Date())
        addedItems.append(entry)
        update()
    }

    static func strToDouble(_ s: String) -> Double {
        var str = s
        let parts = s.split(separator: ".")
        var val: String = ""
        if parts.count > 2 {
            val += parts[0] + "."
            for i in 1..<parts.count {
                val += parts[i]
            }
            str = val
        }
        return Double(str) ?? 0
    }

    static func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }

    func getSearchResults(query: String?, category: String) -> [ListItem] {
        var items: [ListItem] = listItems

        if category != "" {
            items = items.filter({ (item) -> Bool in
                item.topCategory == category
            })
        }

        if query == nil {
            return items
        }

        let fuse = Fuse()
        for item in items {
            let result = fuse.search(query!, in: item.description)
            item.searchScore = result?.score ?? 2
        }

        let results = items.sorted { (a, b) -> Bool in
            return a.searchScore < b.searchScore
        }

        return results.filter { (item) -> Bool in
            return item.searchScore <= 0.5
        }
    }

    static func unitForCategory(_ category: String) -> String {
        print("unitForCategory")
        print(category)
        if category == "Food" {
            return "kg"
        }
        if category == "Transport" {
            return "km"
        }
        return ""
    }
}
