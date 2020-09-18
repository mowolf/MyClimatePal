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
    var body: some View {
        LineView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Full screen").padding() // legend is optional, use optional .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
