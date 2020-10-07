//
//  ContentView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: ContentView contains TabBarView and Onboarding
    
    /// Onboarding related
    @State private var selection = 0
    @State private var viewIdx = 0
    @State private var onboardingCompleted = false
    let headline = ["Our earth is in danger", "Climate Change will set it on fire", "Learn to live more climate friendly"]
    let description = ["Increases in greenhouse gases leads to a raising average temperature. Carbon dioxide is the most important of Earth's long-lived greenhouse gases.", "We all need to fight this trend! With MyClimatePal you now can actively work against this trend and lower your Co2 emissions!", "Track your Co2 consumption and be informed what you can do to save our planet. Plant trees to offset your emissions!" ]
    let img = ["earth-green", "earth-burning", "logo" ]
    
    /// model
    var myCo2State: Co2State = Co2State(currentCo2State: 20.0)

    var body: some View {
        /// this is an ugly workaround as view does not update otherwise
        if myCo2State.onboardingCompleted || onboardingCompleted {
            // MARK: Normal TAB View
            TabView(selection: $selection) {
                DashboardView().environmentObject(myCo2State)
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "chart.pie")
                            Text("Today")
                        }
                    }
                    .tag(0)

                AddView().environmentObject(myCo2State)
                    .tabItem {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Co2")
                    }
                }.tag(1)

                HistoryView().environmentObject(myCo2State)
                    .tabItem {
                        VStack {
                            Image(systemName: "tray.full").resizable()
                            Text("History")
                        }
                    }
                    .tag(2)
            }
        } else {
            // MARK: Onboarding View
            /// currently in this view, but it needs to down and up pass data
            VStack {
                if !img[viewIdx].isEmpty {
                    Image(img[viewIdx]).resizable().frame(width: 340, height: 340, alignment: .center)
                }
            Text(headline[viewIdx])
                .font(.largeTitle)
                .bold()
                .frame(width: 350, alignment: .top)
                .padding()
                Spacer().frame(minHeight: 0, idealHeight: 40, maxHeight: 40)

                VStack {
                    Text(description[viewIdx]).frame(width: 350).multilineTextAlignment(.center)
                }
            Spacer()
            HStack {
                Button(action: {
                        if viewIdx > 0 {
                            viewIdx -= 1
                        } else {
                            // Navigate to Main View
                            onboardingCompleted = true
                            myCo2State.onboardingCompleted = true
                            myCo2State.update()
                        }
                }, label: {
                    Text((viewIdx > 0) ? "Back" : "Skip").foregroundColor(.gray)
                }).padding()

                Button((viewIdx != description.count-1) ? "Next" : "Start") {
                    if viewIdx < description.count - 1 {
                        viewIdx += 1
                    } else {
                        // Navigate to Main View
                        onboardingCompleted = true
                        myCo2State.onboardingCompleted = true
                        myCo2State.update()
                    }
                }.padding()
            }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
