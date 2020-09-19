//
//  ListItemAdded.swift
//  myclimatepal
//
//  Created by Valentin Wolf on 19.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

class Entry: NSObject, Identifiable, ObservableObject, NSCoding {
    let id = UUID()
    var category: String
    var type: String
    var amount: Double
    var dateAdded: Date
    
    init(category: String, type: String, amount: Double, dateAdded: Date) {
        self.category = category
        self.type = type
        self.amount = amount
        self.dateAdded = dateAdded
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(category, forKey: "category")
        coder.encode(type, forKey: "type")
        coder.encode(amount, forKey: "amount")
        coder.encode(dateAdded, forKey: "dateAdded")
    }

    required init(coder: NSCoder) {
        category = coder.decodeObject(forKey: "category") as! String
        type = coder.decodeObject(forKey: "type") as! String
        amount = coder.decodeDouble(forKey: "amount")
        dateAdded = coder.decodeObject(forKey: "dateAdded") as! Date
    }

}
