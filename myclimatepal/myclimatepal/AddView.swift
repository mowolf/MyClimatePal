//
//  SearchView.swift
//  myclimatepal
//
//  Created by Korbinian Abstreiter on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI
import Combine

struct AddView: View {
    @State var searchText = ""
    @State var searchResults: [ListItem] = []
    @State var selectedItem: ListItem?
    @State var co2entered: String = ""
    @EnvironmentObject var co2State: Co2State

    let iconSize: CGFloat = 150
    
    var body: some View {
        VStack {
            Spacer()
            Text("Update your co2 score").font(.title).animation(.easeIn)
            SearchBar(text: $searchText, selectedItem: $selectedItem).padding().animation(.easeIn(duration: 0.2))
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
            } else if selectedItem != nil {
                Spacer()
                VStack {
                    Text(selectedItem!.description)
                        .font(.largeTitle)
                        .padding()
                    HStack {
                        TextField("Amount", value: $co2entered, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .frame(width: 200)
                            .padding(.all)
                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                            .mask(RoundedRectangle(cornerRadius: 10.0))
                            .onReceive(Just(co2entered), perform: { (newVal: String) in
                                let parts = newVal.split(separator: ".")
                                var val: String = ""
                                if parts.count > 2 {
                                    val += parts[0] + "."
                                    for i in 1..<parts.count {
                                        val += parts[i]
                                    }
                                    self.co2entered = val
                                }
                            })
                        Text("kg")
                    }
                    Spacer()
                    Button(action: {
                        co2State.addEntry(item: selectedItem!, amount: Co2State.strToDouble(co2entered))
                        selectedItem = nil
                        searchText = ""
                    }) {
                        Text("Add")
                    }
                        .frame(width: 200)
                        .padding(.all)
                        //.background(Color(red: 65/255.0, green: 76/255.0, blue: 179/255.0, opacity: 1.0))
                        .background(LinearGradient(gradient: Gradient(colors:
                                                                        [Color(red: 0.8*65/255.0, green: 0.8*76/255.0, blue: 0.8*179/255.0, opacity: 1.0),
                                                                         Color(red: 1.1*65/255.0, green: 1.1*76/255.0, blue: 1.1*179/255.0, opacity: 1.0)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        .foregroundColor(.white)
                    Spacer()
                }
                Spacer()
            } else {
                ListView(items: Co2State.getSearchResults(query: searchText, items: co2State.foodItems), selectedItem: $selectedItem)
                    .environmentObject(co2State)
            }
        }
        .frame(maxHeight: .infinity, alignment: .leading).animation(.easeIn(duration: 0.2))
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
