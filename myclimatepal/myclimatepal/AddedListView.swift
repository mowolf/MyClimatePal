//
//  AddedListView.swift
//  myclimatepal
//
//  Created by Valentin Wolf on 19.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct AddedListView: View {
    var items: [Entry]
    @Binding var selectedItem: Entry?
    @Binding var co2entered: String

    @EnvironmentObject var co2State: Co2State
    
    var body: some View {
        List(items) { item in
            Button(action: {
                self.selectedItem = item
                self.co2entered = item.amount.description
            }) {
                HStack {
                    Text(item.type)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(item.amount.description + " kg").foregroundColor(Color.orange)
                        Text(String(format: "%.2f",item.amount * co2State.listItemsDict[item.type]!.CO2eqkg) + " kg Co2")
                    }
                }
            }
        }
    }
}
