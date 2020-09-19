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
    @State var selectedCategory: String = ""
    @EnvironmentObject var co2State: Co2State

    let iconSize: CGFloat = 150

    var body: some View {
        VStack {
            Text("Add Co2 Emissions")
                    .font(.largeTitle).bold().frame(width: 400, alignment: .top).padding(.top).padding()
            HStack {
                SearchBar(text: $searchText, selectedItem: $selectedItem)
                    .padding()
                if selectedItem != nil || selectedCategory != "" || searchText != "" {
                    Button(action: {
                        selectedCategory = ""
                        selectedItem = nil
                        searchText = ""
                        co2entered = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Back")
                    }
                    .offset(x: -20)
                    //.padding(.trailing, 20)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }

            if !(selectedItem != nil || selectedCategory != "" || searchText != "") {
                Spacer().frame(minHeight: 0, maxHeight: 80)
            }

            // MARK: show item / add screen
            if selectedItem != nil {
                Spacer().frame(minHeight: 20, maxHeight: 100)
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 300, height: 300, alignment: .center)
                        .shadow(radius: 8)
                    VStack {
                        Text(selectedItem!.description)
                            .font(.title)
                            .lineLimit(2)
                            .frame(width: 250)
                            .multilineTextAlignment(.center)
                            .padding()
                        HStack {
                            TextField("Amount", text: $co2entered)
                                .keyboardType(.decimalPad)
                                .frame(width: 200)
                                .padding()
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .mask(RoundedRectangle(cornerRadius: 10.0))
                                .onReceive(Just(co2entered), perform: { (newVal: String) in
                                    let parts = newVal.components(separatedBy: ".")
                                    print(parts)
                                    var val: String = ""
                                    if parts.count > 2 {
                                        val += parts[0] + "."
                                        for i in 1..<parts.count {
                                            val += parts[i]
                                        }
                                        self.co2entered = val
                                    }
                                })

                            Text(Co2State.unitForCategory(selectedItem!.topCategory)).font(.system(size: 18))
                        }

                        Text("\(String(format: "%.2f", (Double(co2entered) ?? 0) * selectedItem!.CO2eqkg)) kg CO2 (+\(String(format: "%.1f", (Double(co2entered) ?? 0) * selectedItem!.CO2eqkg / co2State.co2max)) %)")
                            .font(.system(size: 15)).foregroundColor(.gray).padding()

                        Button(action: {
                            self.co2State.addEntry(item: self.selectedItem!, amount: Co2State.strToDouble(self.co2entered))
                            self.selectedItem = nil
                            self.searchText = ""
                            self.co2entered = ""
                        }) {
                            Text("Add").padding(.all, 20)
                        }

                    }
                    .padding()
                }
                Spacer()

            } else if searchText != "" {
                ListView(items: co2State.getSearchResults(query: self.searchText, category: self.selectedCategory), selectedItem: $selectedItem)
                    .environmentObject(co2State)
            } else if selectedCategory != "" {
                ListView(items: co2State.getSearchResults(query: nil, category: self.selectedCategory), selectedItem: $selectedItem)
                    .environmentObject(co2State)
            } else {
                HStack {
                    Button(action: {
                        self.selectedCategory = "Transport"
                    }) {
                        Image("car")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {
                        self.selectedCategory = "Home"
                    }) {
                        Image("home")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }.buttonStyle(PlainButtonStyle())
                }
                HStack {
                    Button(action: {
                        self.selectedCategory = "Food"
                    }) {
                        Image("food")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {
                        self.selectedCategory = "Clothing"
                    }) {
                        Image("jumper")
                            .font(.system(size: 60))
                            .frame(width: iconSize, height: iconSize)
                    }.buttonStyle(PlainButtonStyle())
                }
                Spacer()
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
