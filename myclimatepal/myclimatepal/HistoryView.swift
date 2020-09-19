//
//  HistoryView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI
import SwiftUICharts
//import Combine

struct HistoryView: View {
    @EnvironmentObject var co2State: Co2State

    @State var selectedItem: AddedItem?
    @State var selectedItem2: ListItem?
    
    var body: some View {
        VStack{
            Text("Your History")
                .font(.largeTitle)
                .bold()
//            ListView(items: Co2State.getSearchResults(query: "Garlic", items: co2State.foodItems), selectedItem: $selectedItem2)
//                .environmentObject(co2State)
//            LineView(data: co2State.co2HistoryData, legend: "kg co2 ")
//                .padding()

//
            AddedListView(items: co2State.addedItems, selectedItem: $selectedItem)
                .environmentObject(co2State)

//            ListView(items: "Garlic", selectedItem: selectedItem2)
//                .environmentObject(co2State)


        }

        
        
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView().environmentObject(Co2State(currentCo2State: 10.0))
//    }
//}
