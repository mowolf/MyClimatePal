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
    
    let iconSize: CGFloat = 150
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            Spacer()
            HStack {
                Button(action: {
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
        }
        .frame(maxHeight: .infinity, alignment: .leading)
    }
}

