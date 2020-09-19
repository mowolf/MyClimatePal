//
//  ListItemAdded.swift
//  myclimatepal
//
//  Created by Valentin Wolf on 19.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

class AddedItem: Identifiable {
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
        
        print(type)
    }
}
