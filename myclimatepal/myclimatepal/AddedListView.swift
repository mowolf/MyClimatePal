//
//  AddedListView.swift
//  myclimatepal
//
//  Created by Valentin Wolf on 19.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct AddedListView: View {
    var items: [AddedItem]
    @Binding var selectedItem: AddedItem?
    
    var body: some View {
        List(items) { item in
            Button(action: {
                self.selectedItem = item
            }) {
                Text(item.type)
                Text(item.category)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
                Text(item.amount.description).foregroundColor(Color.orange).multilineTextAlignment(.trailing)
            }
        }
    }
}