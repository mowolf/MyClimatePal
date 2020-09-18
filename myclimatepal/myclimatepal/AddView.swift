//
//  SearchView.swift
//  myclimatepal
//
//  Created by Korbinian Abstreiter on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State var searchText = ""
    @State var searchResults: [ListItem] = []
    @EnvironmentObject var co2State: Co2State

    let iconSize: CGFloat = 150
    
    var body: some View {
        VStack {
            Spacer()
            Text("Update your co2 score").font(.title)
            SearchBar(text: $searchText).padding()
            if searchText == "" {
                HStack {
                    Button(action: {
                        self.co2State.currentCo2State += 2
                        // What to perform
                    }) {
                        Image("car")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {
                        // What to perform
                    }) {
                        Image("home")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }.buttonStyle(PlainButtonStyle())
                }
                HStack {
                    Button(action: {
                        // What to perform
                    }) {
                        Image("food")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {
                        // What to perform
                    }) {
                        Image("jumper")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }.buttonStyle(PlainButtonStyle())
                }
                Spacer()
            } else {
                ListView(items: Co2State.getSearchResults(query: searchText, items: co2State.foodItems))
            }
        }
        .frame(maxHeight: .infinity, alignment: .leading)
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
