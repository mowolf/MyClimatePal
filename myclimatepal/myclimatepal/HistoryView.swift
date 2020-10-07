//
//  HistoryView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI
import Combine

struct HistoryView: View {
    @EnvironmentObject var co2State: Co2State

    @State var selectedItem: Entry?
    @State var selectedDate: Date = Date()
    @State var selectedRecurrence: String = "1"
    @State var co2entered: String = ""

    var body: some View {
        VStack {
            if selectedItem != nil {
                Text("Edit Entry")
                    .font(.largeTitle).bold().frame(width: 400, alignment: .top).padding(.top)
                Spacer().frame(minHeight: 20, maxHeight: 177)

                // show item / add screen

                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 300, height: 350, alignment: .center)
                        .shadow(radius: 8)

                VStack {
                    VStack {
                        Text(selectedItem!.type)
                            .font(.title)
                            .lineLimit(2)
                            .frame(width: 250)
                            .multilineTextAlignment(.center)
                            .padding()
//                        if let source = selectedItem.sourceId {
//                           // Do something using `xy`.
//                        }
                    }

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
                        Text(co2State.listItemsDict[selectedItem!.type]!.unit).font(.system(size: 18))
                    }
                    let co2amount: Double = co2entered.numericString(allowDecimalSeparator: true).parseDouble()
                    let formattedCO2: String = (co2amount * co2State.listItemsDict[selectedItem!.type]!.CO2eqkg).getFormatted(digits: 3)
                    let formattedPercent: String = (co2amount * co2State.listItemsDict[selectedItem!.type]!.CO2eqkg / co2State.co2max * 100).getFormatted(digits: 1)
                    Text("\(formattedCO2) kg CO2 (\(formattedPercent)%)")
                        .font(.system(size: 15)).foregroundColor(.gray).padding()

                    DatePicker("Title, hidden due to labelsHidden", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                    
                    if #available(iOS 14.0, *) {
                        Picker(selection: $selectedRecurrence, label: Text("Recurrence:")) {
                            Text("once").tag("1")
                            Text("daily").tag("d")
                            Text("weekly").tag("w")
                            Text("month").tag("m")
                            Text("yearly").tag("y")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 260)
                        .padding(.top)
                    }

                    HStack {
                        Button(action: {
                            /*let index = co2State.addedItems.firstIndex(of: selectedItem!)
                            co2State.addedItems[index!].amount = self.co2entered.numericString(allowDecimalSeparator: true).parseDouble()
                            co2State.addedItems[index!].dateAdded = selectedDate*/
                            if selectedItem!.recurrence == "1" {
                                selectedItem!.amount = self.co2entered.numericString(allowDecimalSeparator: true).parseDouble()
                                selectedItem!.dateAdded = selectedDate
                            } else {
                                // remove all
                                co2State.addedItems.removeAll { (e: Entry) -> Bool in
                                    return e.recurrenceID == selectedItem!.recurrenceID
                                }
                                // add again
                                self.co2State.addEntry(item: self.co2State.listItemsDict[self.selectedItem!.type]!, amount: self.co2entered.numericString(allowDecimalSeparator: true).parseDouble(), dateAdded: selectedDate, recurrence: selectedRecurrence)
                            }
                            self.selectedItem = nil
                            self.co2entered = ""
                            co2State.update()
                        }) {
                            Text("Save").font(.system(size: 18))
                        }
                            .frame(width: 100)
                        .padding(.all, 20)

                        Button(action: {
                            co2State.addedItems.removeAll { (e: Entry) -> Bool in
                                return e.recurrenceID != -1 ? selectedItem!.recurrenceID == e.recurrenceID : selectedItem!.id == e.id
                            }
                            selectedItem = nil
                            self.co2entered = ""
                            co2State.update()

                        }) {
                            Text("Delete").font(.system(size: 18)).foregroundColor(.red)
                        }
                            .frame(width: 100)
                        .padding(.all, 20)
                    }
                }

                }
                //.modifier(DismissingKeyboard())
                Spacer()
            } else {
                Text("Emission History")
                    .font(.largeTitle)
                    .bold()
                    .frame(width: 400, alignment: .top)
                    .padding(.top)
                Spacer().frame(minHeight: 20, maxHeight: 20)
                AddedListView(items: co2State.addedItems.reversed(), selectedItem: $selectedItem, selectedDate: $selectedDate, selectedRecurrence: $selectedRecurrence, co2entered: $co2entered)
                    .environmentObject(co2State)
            }
        }
    }
}
