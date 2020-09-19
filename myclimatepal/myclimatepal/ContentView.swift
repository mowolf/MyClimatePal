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
        TabView(selection: $selection){
            co2statView().environmentObject(myCo2State)
                .font(.title)
                .tabItem {
                    VStack {
                        Image("graph")
                        Text("Today")
                    }
                }
                .tag(0)
            
            AddView().environmentObject(myCo2State)
                .tabItem {
                VStack {
                    Image("co2-plus")
                    Text("Add")
                }
            }.tag(1)
            
            HistoryView().environmentObject(myCo2State)
                .font(.title)
                .tabItem {
                    VStack {
                        Image("history").resizable()
                        Text("List")
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
