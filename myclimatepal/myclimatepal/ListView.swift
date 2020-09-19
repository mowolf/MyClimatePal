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
                self.selectedItem = item
            }) {
                VStack(alignment: .leading) {
                    Text(item.description)
                    Text(item.category)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                    Text("\(item.CO2eqkg.description) kgCo2/\(Co2State.unitForCategory(item.topCategory))").foregroundColor(Color.orange).multilineTextAlignment(.trailing)
                }
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
