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
 
    var body: some View {
        TabView(selection: $selection){
            co2statView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle.fill")
                        Text("Today")
                    }
                }
                .tag(0)
            
            AddView()
                .tabItem {
                VStack {
                    Image(systemName: "plus")
                    Text("Add")
                }
            }
            
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "list.dash")
                        Text("List")
                    }
                }
                .tag(1)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
