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
    @EnvironmentObject var co2State: Co2State
    
    var body: some View {
        List(items) { item in
            
            Button(action: {
                self.selectedItem = item
            }) {
                VStack(alignment: .leading) {
                    Text(item.type)
                    Text(item.category)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                    Text(item.amount.description + " kg").foregroundColor(Color.orange).multilineTextAlignment(.trailing)
                    Text(String(format: "%.2f",item.amount * co2State.foodItemsDict[item.type]!.CO2eqkg) + " kg Co2").multilineTextAlignment(.trailing)
                }
            }
        }
    }
}
