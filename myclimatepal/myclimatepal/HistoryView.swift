//
//  HistoryView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct HistoryView: View {
    
    @EnvironmentObject var Co2State: Co2State
    
    var body: some View {
        VStack{
            Text("Your History")
                .font(.largeTitle)
                .bold()
            LineView(data: Co2State.co2HistoryData, legend: "kg co2 ")
                .padding()
        }
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(Co2State(currentCo2State: 10.0))
    }
}
