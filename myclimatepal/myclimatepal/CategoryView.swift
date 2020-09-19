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
        let cats = ["Food", "Transport", "Clothing", "Home"]
        let data = cats.map { (cat) -> Double in
            return co2State.co2categoryTotal[cat]!
        }
        //PieChartView(labels: co2State.co2categoryTotal.map{$0.0}, data: co2State.co2categoryTotal.map{$0.1}, title: "Total Co2 per Category", legend: "kg co2", form: ChartForm.large).frame(height: 300)
        PieChartView(labels: cats, data: data, title: "Total Co2 per Category", legend: "kg co2", form: ChartForm.large).frame(height: 300)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
