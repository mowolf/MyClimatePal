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
import SwiftUI

final class Co2State: ObservableObject {
    // MARK: Co2
    @Published var treeOffsetNum: Int = 0
    @Published var currentCo2State: Double = 0.0
    @Published var co2max = 11.0
    @Published var co2HistoryData: [Double] = []//[8, 23, 54, 32, 12, 37, 7, 23, 43]
    @Published var co2categoryTotal: [String: Double] = [:]//["Transport": 8, "Food" :23]

    var co2data: [String: Any]
    var listItems: [ListItem] = []
    var listItemsDict: [String: ListItem] = [:]
    @Published var addedItems: [Entry] = []

    init(currentCo2State: Double = 0.0) {
        self.currentCo2State = currentCo2State

        co2data = Co2State.readJSONFromFile(fileName: "Co2_data") as? [String: Any] ?? [:]
        for x in co2data {
            // i has no idea what is happening here but it works
            let info = x.value as! [String: Any]
            let category: String = info["category"] as! String
            let CO2eqkg: NSNumber = info["CO2eqkg"]! as! NSNumber
            let unit: String = info["unit"] as? String ?? "g"
            let unitPerKg: NSNumber = info["unitPerKg"] as? NSNumber ?? NSNumber(1000)
            listItems.append(ListItem(description: x.key, category: category, CO2eqkg: CO2eqkg.doubleValue, topCategory: "Food", unit: unit, unitPerKg: unitPerKg.doubleValue))
        }

        // MARK: New Items to add to our Data
        // MARK: TRANSPORT
        listItems.append(ListItem(description: "🚗 Car", category: "Transport", CO2eqkg: 0.130, topCategory: "Transport", unit: "km"))
        listItems.append(ListItem(description: "🚌 Bus", category: "Transport", CO2eqkg: 0.068, topCategory: "Transport", unit: "km"))
        listItems.append(ListItem(description: "🚂 Train", category: "Transport", CO2eqkg: 0.014, topCategory: "Transport", unit: "km"))
        listItems.append(ListItem(description: "✈️ Plane", category: "Transport", CO2eqkg: 0.285, topCategory: "Transport", unit: "km"))
        listItems.append(ListItem(description: "🛳 Ship", category: "Transport", CO2eqkg: 0.245, topCategory: "Transport", unit: "km"))
        // MARK: HOME https://www.eea.europa.eu/data-and-maps/daviz/co2-emission-intensity-5#tab-googlechartid_chart_11_filters=%7B%22rowFilters%22%3A%7B%7D%3B%22columnFilters%22%3A%7B%22pre_config_ugeo%22%3A%5B%22European%20Union%20(current%20composition)%22%5D%7D%7D
        listItems.append(ListItem(description: "⚡️🇪🇺 EU Electricity", category: "Power", CO2eqkg: 0.300, topCategory: "Home", unit: "kwH"))
        listItems.append(ListItem(description: "⚡️🇨🇭 CH Electricity", category: "Power", CO2eqkg: 0.024, topCategory: "Home", unit: "kwH"))
        listItems.append(ListItem(description: "⚡️🇩🇪 DE Electricity", category: "Power", CO2eqkg: 0.480, topCategory: "Home", unit: "kwH"))
        listItems.append(ListItem(description: "⚡️🇳🇴 N Electricity", category: "Power", CO2eqkg: 0.008, topCategory: "Home", unit: "kwH"))
        listItems.append(ListItem(description: "⚡️🇦🇹 Ö Electricity", category: "Power", CO2eqkg: 0.166, topCategory: "Home", unit: "kwH"))
        listItems.append(ListItem(description: "⚡️🇫🇷 FR Electricity", category: "Power", CO2eqkg: 0.064, topCategory: "Home", unit: "kwH"))
        listItems.append(ListItem(description: "⚡️🇮🇹 IT Electricity", category: "Power", CO2eqkg: 0.350, topCategory: "Home", unit: "kwH"))

        // MARK: Clothing
        listItems.append(ListItem(description: "👕  Polyester T-shirt", category: "Clothing", CO2eqkg: 20, topCategory: "Clothing", unit: "item"))
        listItems.append(ListItem(description: "👕  Cotton T-shirt", category: "Clothing", CO2eqkg: 10, topCategory: "Clothing", unit: "item"))
        listItems.append(ListItem(description: "👕  Organic Cotton T-shirt", category: "Clothing", CO2eqkg: 4, topCategory: "Clothing", unit: "item"))
        listItems.append(ListItem(description: "👟  Sport Shoe", category: "Clothing", CO2eqkg: 15, topCategory: "Clothing", unit: "item"))
        listItems.append(ListItem(description: "👞  Shoe", category: "Clothing", CO2eqkg: 10, topCategory: "Clothing", unit: "item"))
        listItems.append(ListItem(description: "🩳  Short Cotton Pants", category: "Clothing", CO2eqkg: 10, topCategory: "Clothing", unit: "item"))
        listItems.append(ListItem(description: "🩳  Short Polyester Pants", category: "Clothing", CO2eqkg: 4, topCategory: "Clothing", unit: "item"))
        listItems.append(ListItem(description: "👖  Jeans", category: "Clothing", CO2eqkg: 34, topCategory: "Clothing", unit: "item"))

        for item in listItems {
            listItemsDict[item.description] = item
        }

        let value = UserDefaults.standard.object(forKey: "addedItems") as? Data
        if value != nil {
            addedItems = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value!) as? [Entry] ?? []
        } else {
            let foodItems = listItems.filter { (item) -> Bool in
                return item.topCategory == "Food"
            }
            let clothingItems = listItems.filter { (item) -> Bool in
                return item.topCategory == "Clothing"
            }
            let homeItems = listItems.filter { (item) -> Bool in
                return item.topCategory == "Home"
            }
            let homeItem = homeItems[Int.random(in: 0..<homeItems.count)]
            for i in 0..<15 {
                for _ in 0..<Int.random(in: 3..<6) {
                    let item = foodItems[Int.random(in: 0..<foodItems.count)]
                    addedItems.append(Entry(category: item.category, type: item.description, amount: round(Double.random(in: 0.05..<0.3)*100)/100, dateAdded: Date().addingTimeInterval(-Double(i)*24*60*60)))
                }
                for _ in 0..<Int.random(in: 1..<3) {
                    let item = clothingItems[Int.random(in: 0..<clothingItems.count)]
                    addedItems.append(Entry(category: item.category, type: item.description, amount: round(Double.random(in: 0.05..<0.3)*100)/100, dateAdded: Date().addingTimeInterval(-Double(i)*24*60*60)))
                }
                for _ in 0..<Int.random(in: 1..<2) {
                    let item = homeItem
                    addedItems.append(Entry(category: item.category, type: item.description, amount: round(Double.random(in: 10..<40)*100)/100, dateAdded: Date().addingTimeInterval(-Double(i)*24*60*60)))
                }
            }

            // MARK: Items show up in History
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 74, dateAdded: Date().addingTimeInterval(-1*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚌 Bus", amount: 70, dateAdded: Date().addingTimeInterval(-2*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚂 Train", amount: 110, dateAdded: Date().addingTimeInterval(-3*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 74, dateAdded: Date().addingTimeInterval(-4*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 155, dateAdded: Date().addingTimeInterval(-5*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 35, dateAdded: Date().addingTimeInterval(-6*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚌 Bus", amount: 20, dateAdded: Date().addingTimeInterval(-7*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 114, dateAdded: Date().addingTimeInterval(-8*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 64, dateAdded: Date().addingTimeInterval(-9*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 134, dateAdded: Date().addingTimeInterval(-10*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 114, dateAdded: Date().addingTimeInterval(-11*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 114, dateAdded: Date().addingTimeInterval(-12*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 114, dateAdded: Date().addingTimeInterval(-13*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 114, dateAdded: Date().addingTimeInterval(-14*24*60*60)))
            /*
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 30, dateAdded: Date().addingTimeInterval(-1*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🧄 Garlic", amount: 20, dateAdded: Date().addingTimeInterval(-2*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 10, dateAdded: Date().addingTimeInterval(-1*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🧄 Garlic", amount: 40, dateAdded: Date().addingTimeInterval(-3*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚂 Train", amount: 10, dateAdded: Date().addingTimeInterval(-1*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🧄 Garlic", amount: 50, dateAdded: Date().addingTimeInterval(-4*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "✈️ Plane", amount: 10, dateAdded: Date().addingTimeInterval(-1*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 30, dateAdded: Date().addingTimeInterval(-4*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🧄 Garlic", amount: 20, dateAdded: Date().addingTimeInterval(-5*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 10, dateAdded: Date().addingTimeInterval(-6*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🧄 Garlic", amount: 40, dateAdded: Date().addingTimeInterval(-7*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚂 Train", amount: 10, dateAdded: Date().addingTimeInterval(-8*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🐷 Pork EU", amount: 50, dateAdded: Date().addingTimeInterval(-9*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "✈️ Plane", amount: 10, dateAdded: Date().addingTimeInterval(-10*24*60*60)))

            
            addedItems.append(Entry(category: "Food", type: "🐷 Pork EU", amount: 0.2, dateAdded: Date().addingTimeInterval(-9*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🥔 Potatoes", amount: 0.5, dateAdded: Date().addingTimeInterval(-9*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🌾 Oats", amount: 0.12, dateAdded: Date().addingTimeInterval(-9*24*60*60)))
            addedItems.append(Entry(category: "Food", type: "🥛 Yoghurt", amount: 0.25, dateAdded: Date().addingTimeInterval(-9*24*60*60)))

            addedItems.append(Entry(category: "Transport", type: "✈️ Plane", amount: 10, dateAdded: Date().addingTimeInterval(-10*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚂 Train", amount: 10, dateAdded: Date().addingTimeInterval(-8*24*60*60)))
            addedItems.append(Entry(category: "Transport", type: "🚗 Car", amount: 10, dateAdded: Date().addingTimeInterval(-6*24*60*60)))
             */
        }

        update()
    }

    func update() {
        saveEntries()
        updateCurrentCo2()
        co2HistoryData = getCo2PerDay()
        co2categoryTotal = getCo2CategoryTotal()
        treeOffsetNum = updateTreeOffsetNum()
    }

    func updateTreeOffsetNum() -> Int {
        var neededTreesToday: Int = 0

        neededTreesToday = Int(currentCo2State / 0.0617) // 22kgCO2 is accumulated per tree per year

        return neededTreesToday
    }

    func getCo2CategoryTotal() -> [String: Double] {
        var catTotal: [String: Double] = ["Food":0, "Transport": 0, "Clothing": 0, "Home": 0]
        for entry in addedItems {
            let item = listItemsDict[entry.type]!
            let cat = item.topCategory
            catTotal[cat] = entry.amount * item.CO2eqkg / item.unitPerKg + (catTotal[cat] ?? 0)
        }
        return catTotal
    }

    func updateCurrentCo2() {
        var co2: Double = 0
        for item in addedItems {
            if Calendar.current.dateComponents([.day], from: item.dateAdded, to: Date()).day == 0 {
                co2 += listItemsDict[item.type]!.CO2eqkg * item.amount / listItemsDict[item.type]!.unitPerKg
            }
        }
        currentCo2State = co2
    }

    func getCo2PerDay(category: String = "", n_days: Int = 10) -> [Double] {
        var co2Stats: [Int: Double] = [:]
        for item in addedItems {
            let daysDiff = Calendar.current.dateComponents([.day], from: item.dateAdded, to: Date()).day ?? 0
            co2Stats[daysDiff] = listItemsDict[item.type]!.CO2eqkg * item.amount / listItemsDict[item.type]!.unitPerKg + (co2Stats[daysDiff] ?? 0)
        }
        var result: [Double] = []
        for i in 0..<n_days {
            result.append(co2Stats[n_days - i - 1] ?? 0)
        }
        return result
    }

    func getColorForItem(item: ListItem) -> Color {
        let colors = [Color.green, Color.green, Color.yellow, Color.orange, Color.red, Color(red: 0.85, green: 0, blue: 0)]
        let catItems = listItems.filter { (listItem) -> Bool in
            return listItem.topCategory == item.topCategory
        }.map { (listItem) -> Double in
            listItem.CO2eqkg
        }
        // mean calculation
        //let catMin = catItems.min()!
        //let catMax = catItems.max()!
        //let score = (item.CO2eqkg - catMin) / (catMax - catMin)
        var n_higher: Double = 0
        for catItem in catItems {
            if item.CO2eqkg < catItem {
                n_higher += 1
            }
        }
        let score = 1 - n_higher / Double(catItems.count)
        let i = Int(min(score, 0.99) * Double(colors.count))
        return colors[i]
    }

    func getColorForEntry(entry: Entry) -> Color {
        let colors = [Color.green, Color.yellow, Color.orange, Color.red, Color(red: 0.85, green: 0, blue: 0), Color(red: 0.7, green: 0, blue: 0)]
        let score = min(entry.amount * listItemsDict[entry.type]!.CO2eqkg / listItemsDict[entry.type]!.unitPerKg / co2max, 1)
        let i = Int(min(score, 0.99) * Double(colors.count))
        return colors[i]
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

        // only filter when not searching
        if query == nil && category != "" {
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

    static func unitForCategory(_ category: String, _ subcategory: String?) -> String {
        if category == "Food" {
            return "kg"
        }
        if category == "Transport" {
            return "km"
        }
        if category == "Clothing" {
            return "item"
        }

        if subcategory == "Power" {
            return "kwH"
        }
        return ""
    }
}
