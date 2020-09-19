//
//  co2statView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    // MARK: DASHBOARD
    @EnvironmentObject var co2State: Co2State

    var body: some View {
        ScrollView {
            VStack {
                // MARK: headline
                Text("Your Co2 Emissions")
                    .font(.largeTitle)
                    .bold()
                    .frame(width: 400, alignment: .top)
                    .padding()

                // MARK: Earth
                UsedPercentage()

                // MARK: History Grapth
                DayGraph()
                    .frame(height: 270, alignment: .center)

                // MARK: Categories
                CategoryView()

                // MARK: Trees
                TreeView()
            }
        }
    }
}

struct co2statView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(Co2State(currentCo2State: 50))
    }
}
