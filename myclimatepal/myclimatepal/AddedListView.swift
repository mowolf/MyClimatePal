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
        List {
            let groupedItems = Dictionary(grouping: items, by: { Date.getFormattedDate(date: $0.dateAdded, formatter: "YYYYMMdd") }).map { ($0.key, $0.value) }.sorted(by: {$0.0 > $1.0})

            ForEach(groupedItems, id: \.self.0) { group in
                Section(header: ListHeader(date: group.1[0].dateAdded)) { //footer: ListFooter()
                    ForEach(group.1) { item in
//                        Text(item.amount.description)
                        Button(action: {
                            self.selectedItem = item
                            self.co2entered = item.amount.getFormatted()
                        }) {
                            HStack {
                                Text(item.type).font(.system(size: 18))
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(item.amount.getFormatted(digits: 3) + " \(Co2State.unitForCategory(co2State.listItemsDict[item.type]!.topCategory, co2State.listItemsDict[item.type]!.category))")
                                    Text((item.amount * co2State.listItemsDict[item.type]!.CO2eqkg).getFormatted(digits: 2) + " kg Co2")
                                        .foregroundColor(co2State.getColorForEntry(entry: item))
                                }.font(.system(size: 18))
                            }
                        }
                    }
                }

            }

        }
    }
}

struct ListHeader: View {

    var date: Date
    var body: some View {
        HStack {
            Text(Date.getFormattedDate(date: date, formatter: "MMMM dd"))
        }
    }
}

struct ListFooter: View {
//    @EnvironmentObject var co2State: Co2State

//    var items: [Entry]

    var body: some View {
//        var sum: Double = 0.0
//
//        ForEach(items) { item in
//            sum += item.amount * co2State.listItemsDict[item.type]!.CO2eqkg
//        }
//
        Text("Do we want a footer here?")
    }
}


