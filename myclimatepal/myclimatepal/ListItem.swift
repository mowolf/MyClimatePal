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
    var searchScore: Double = 0
    
    init(description: String) {
        self.description = description
    }
}
