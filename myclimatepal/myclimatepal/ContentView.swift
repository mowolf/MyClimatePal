//
//  ContentView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    var myCo2State: Co2State = Co2State(currentCo2State: 20.0)

    var body: some View {
        TabView(selection: $selection) {
            DashboardView().environmentObject(myCo2State)
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "chart.pie")
                        Text("Today")
                    }
                }
                .tag(0)

            AddView().environmentObject(myCo2State)
                .tabItem {
                VStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Co2")
                }
            }.tag(1)

            HistoryView().environmentObject(myCo2State)
                .tabItem {
                    VStack {
                        Image(systemName: "tray.full").resizable()
                        Text("History")
                    }
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
