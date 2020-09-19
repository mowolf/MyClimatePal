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
                    Text("\(item.amount.description) kgCo2").foregroundColor(Color.orange).multilineTextAlignment(.trailing)
                }
            }
        }
    }
}
