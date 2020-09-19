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

struct Entry {
    var category: String
    var type: String
    var amount: Double
    var dateAdded: Date
}

final class Co2State: ObservableObject {
    // MARK: Co2
    @Published var currentCo2State: Double = 0
    @Published var co2max = 100.0
    @Published var co2HistoryData: [Double] = [8,23,54,32,12,37,7,23,43]
    
    var co2data: [String: Any]
    var foodItems: [ListItem] = []
    var addedItems: [Entry] = []
    
    init(currentCo2State: Double = 0.0) {
        self.currentCo2State = currentCo2State
        
        co2data = Co2State.readJSONFromFile(fileName: "Co2_data") as? [String: Any] ?? [:]
        print(co2data)
        for x in co2data {
            //print(x.key)
            //print(x.value as? [String: Any])
            
            // i has no idea what is happening here but it works
            let category: String = (x.value as! [String: Any])["category"] as! String
            let CO2eqkg: NSNumber = (x.value as! [String: Any])["CO2eqkg"]! as! NSNumber
            
            //print(category)
            //print(CO2eqkg.floatValue)
            foodItems.append(ListItem(description: x.key, category: category, CO2eqkg: CO2eqkg.doubleValue))
        }
        //foodItems
        
        
    }
    
    func addEntry(item: ListItem, amount: Double) {
        let entry = Entry(type: item.description, amount: amount)
        addedItems.append(entry)
        
        print(addedItems)
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
    
    static func getSearchResults(query: String, items: [ListItem]) -> [ListItem] {
        let fuse = Fuse()
        for item in items {
            let result = fuse.search(query, in: item.description)
            item.searchScore = result?.score ?? 2
        }
        
        let results = items.sorted { (a, b) -> Bool in
            return a.searchScore < b.searchScore
        }
        
        return results.filter { (item) -> Bool in
            return item.searchScore <= 0.5
        }
    }
}

