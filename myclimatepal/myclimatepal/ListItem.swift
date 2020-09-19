//
//  ListItem.swift
//  myclimatepal
//
//  Created by Korbinian Abstreiter on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

class ListItem: Identifiable {
    let id = UUID()
    let description: String
    let category: String
    let CO2eqkg: Float
    var searchScore: Double = 0
    
    init(description: String, category: String, CO2eqkg: Float) {
        self.description = description
        self.category = category
        self.CO2eqkg = CO2eqkg
    }
}
