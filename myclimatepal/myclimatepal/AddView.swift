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
    @State var co2entered: String = ""
    @State var selectedCategory: String = ""
    @State var selectedItem: ListItem?
    @State var selectedDate: Date = Date()
    @EnvironmentObject var co2State: Co2State

    let iconSize: CGFloat = 100
    
    let formatter = NumberFormatter()
//    formatter.usesSignificantDigits = true
//    formatter.minimumSignificantDigits = 4

    var body: some View {
        VStack {
            Text("Add Emissions")
                    .font(.largeTitle).bold().frame(width: 400, alignment: .top).padding(.top)
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
                                    self.co2entered = newVal.numericString(allowDecimalSeparator: true)
                                    
                                })

                            Text(Co2State.unitForCategory(selectedItem!.topCategory, selectedItem!.category)).font(.system(size: 18))
                        }
                        let co2amount: Double = self.co2entered.parseDouble()
                        let formattedCO2: String = (co2amount * selectedItem!.CO2eqkg).getFormatted(digits: 3)
                        let formattedPercent: String = (co2amount * selectedItem!.CO2eqkg / co2State.co2max * 100).getFormatted(digits: 1)
                        Text("\(formattedCO2) kg CO2 (\(formattedPercent)%)")
                            .font(.system(size: 15)).foregroundColor(.gray).padding()

                        HStack {
                            Button(action: {
                                self.co2State.addEntry(item: self.selectedItem!, amount: self.co2entered.numericString(allowDecimalSeparator: true).parseDouble())
                                self.selectedItem = nil
                                self.searchText = ""
                                self.co2entered = ""
                            }) {
                                Text("Add").padding(.all, 20)
                            }.frame(width: 100).padding(.all, 20)

                            Button(action: {
                                self.selectedItem = nil
                                self.searchText = ""
                                self.co2entered = ""
                            }) {
                                Text("Cancel").padding(.all, 20).foregroundColor(.red)
                            }.frame(width: 100).padding(.all, 20)
                        }

                    }
                    .padding()
                }
                .modifier(DismissingKeyboard())
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
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 160, height: 160, alignment: .center)
                                .shadow(radius: 8)
                            VStack {
                                Image("car").frame(width: iconSize, height: iconSize)
                                Text("Transportation").bold()
                                }
                            }

                        }.buttonStyle(PlainButtonStyle()).padding()
                    Button(action: {
                        self.selectedCategory = "Home"
                    }) {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 160, height: 160, alignment: .center)
                                .shadow(radius: 8)

                            VStack {
                                Image("home").frame(width: iconSize, height: iconSize)
                                Text("Home").bold()
                                }
                        }
                    }.buttonStyle(PlainButtonStyle()).padding()
                }
                HStack {
                    Button(action: {
                        self.selectedCategory = "Food"
                    }) {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 160, height: 160, alignment: .center)
                                .shadow(radius: 8)

                            VStack {
                                Image("food").frame(width: iconSize, height: iconSize)
                                Text("Food").bold()
                            }
                        }
                    }.buttonStyle(PlainButtonStyle()).padding()

                    Button(action: {
                        self.selectedCategory = "Clothing"
                    }) {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 160, height: 160, alignment: .center)
                                .shadow(radius: 8)

                            VStack {
                                Image("jumper").frame(width: iconSize, height: iconSize)
                                Text("Clothing").bold()
                            }
                        }
                    }.buttonStyle(PlainButtonStyle()).padding()
                }
                Spacer()
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

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}


