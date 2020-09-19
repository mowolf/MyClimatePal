//
//  CategoryView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 19.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var co2State: Co2State
    
    
    var body: some View {
        PieChartView(data: co2State.co2categoryTotal.map{$0.1}, title: "Total Co2 per Category", legend: "kg co2", form: ChartForm.large).frame(height: 300)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
