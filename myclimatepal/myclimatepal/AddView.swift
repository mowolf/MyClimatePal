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
            SearchBar(text: $searchText).padding()
            if searchText == "" {
                Spacer()
                HStack {
                    Button(action: {
                        self.co2State.currentCo2State += 2
                        // What to perform
                    }) {
                        Image(systemName: "scribble")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }
                    Button(action: {
                        // What to perform
                    }) {
                        Image(systemName: "rosette")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }
                }
                HStack {
                    Button(action: {
                        // What to perform
                    }) {
                        Image(systemName: "tortoise")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }
                    Button(action: {
                        // What to perform
                    }) {
                        Image(systemName: "house")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }
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
