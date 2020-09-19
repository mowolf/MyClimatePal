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
    @EnvironmentObject var co2State: Co2State

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
                    Text("\(item.CO2eqkg.description) kgCo2/\(Co2State.unitForCategory(item.topCategory, item.category))")
                        .foregroundColor(co2State.getColorForItem(item: item))
                        .multilineTextAlignment(.trailing)
                }
            }
        }.padding()
    }
}

/*
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}*/
