//
//  SearchResultsView.swift
//  myclimatepal
//
//  Created by Korbinian Abstreiter on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct ListView: View {
    var items: [ListItem]
    @Binding var selectedItem: ListItem?
    
    var body: some View {
        List(items) { item in
            Button(action: {
                selectedItem = item
            }) {
                Text(item.description)
            }
        }
    }
}

/*
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}*/
