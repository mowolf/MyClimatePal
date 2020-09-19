//
//  DayGraph.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 19.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI
import SwiftUICharts

let tempGradient = Gradient(colors: [
  .purple,
  Color(red: 0, green: 0, blue: 139.0/255.0),
  .blue,
  Color(red: 30.0/255.0, green: 144.0/255.0, blue: 1.0),
  Color(red: 0, green: 191/255.0, blue: 1.0),
  Color(red: 135.0/255.0, green: 206.0/255.0, blue: 250.0/255.0),
  .green,
  .yellow,
  .orange,
  Color(red: 1.0, green: 140.0/255.0, blue: 0.0),
  .red,
  Color(red: 139.0/255.0, green: 0.0, blue: 0.0)
])

struct DayGraph: View {
    @EnvironmentObject var co2State: Co2State

    var body: some View {
        GeometryReader { geometry in
            VStack {
                LineView(data: co2State.co2HistoryData).frame(width: geometry.size.width+20, height: 300).offset(x: -20)
                Spacer()
                ScrollView(.horizontal) {
                    HStack {
                        PieChartView(data: [8, 23, 54, 32], title: "Co2 Category", legend: "kg co2").frame(width: geometry.size.width, height: 300)
                        // ADD MORE?
                        // PieChartView(data: [8,23,54,32], title: "Title", legend: "Legendary").frame(width: geometry.size.width, height: 300).offset(x: -geometry.size.width/2-5)
                    }
                }
            }
        }
    }
}

struct DayGraph_Previews: PreviewProvider {
    static var previews: some View {
        DayGraph().environmentObject(Co2State(currentCo2State: 10.0))
    }
}
