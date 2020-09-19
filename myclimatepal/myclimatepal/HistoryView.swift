//
//  HistoryView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI
import SwiftUICharts
import Combine

struct HistoryView: View {
    @EnvironmentObject var co2State: Co2State

    @State var selectedItem: Entry?
    @State var co2entered: String = ""
    
    var body: some View {
        VStack{
            if selectedItem != nil {
                Text("Edit Entry")
                    .font(.largeTitle)
                    .bold()
                    .frame(width: 400, alignment: .top)
                    .padding(.top)
                    .padding()
                Spacer().frame(minHeight: 20, maxHeight: 80)
                // show item / add screen
                VStack {
                    Text(selectedItem!.type)
                        .font(.title)
                        .padding()
                    HStack {
                        TextField("Amount", text: $co2entered)
                            .keyboardType(.decimalPad)
                            .frame(width: 200)
                            .padding(.all)
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
                        Text(Co2State.unitForCategory(co2State.listItemsDict[selectedItem!.type]!.topCategory)).font(.system(size: 18))
                    }
                    Spacer()
                    Text("\(String(format: "%.3f", (Double(co2entered) ?? 0) * co2State.listItemsDict[selectedItem!.type]!.CO2eqkg)) kg CO2 (+x %)")
                    Spacer()
                    HStack {
                        Button(action: {
                            let index = co2State.addedItems.firstIndex(of: selectedItem!)
                            co2State.addedItems[index!].amount = Co2State.strToDouble(self.co2entered)
                            self.selectedItem = nil
                            self.co2entered = ""
                            co2State.update()
                        }) {
                            Text("Update").font(.system(size: 18))
                        }
                            .frame(width: 150)
                            .padding(.all)

                        Button(action: {
                            print(selectedItem!.id)
                            co2State.addedItems.removeAll { (e: Entry) -> Bool in
                                return selectedItem!.id == e.id
                            }
                            selectedItem = nil
                            self.co2entered = ""
                            co2State.update()
                            
                        }) {
                            Text("Delete").font(.system(size: 18)).foregroundColor(.red)
                        }
                            .frame(width: 150)
                            .padding(.all)
                    }
                    Spacer()
                }
                Spacer()
            } else {
                Text("Your History")
                    .font(.largeTitle)
                    .bold()
                    .frame(width: 400, alignment: .top)
                    .padding(.top)
                    .padding()
                Spacer().frame(minHeight: 20, maxHeight: 80)
                AddedListView(items: co2State.addedItems, selectedItem: $selectedItem, co2entered: $co2entered)
                    .environmentObject(co2State)
            }
        }
    }
}
