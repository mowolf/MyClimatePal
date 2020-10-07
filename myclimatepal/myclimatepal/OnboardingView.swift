//
//  OnboardingView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 07.10.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @State var viewIdx

    let headline = ["Be aware of your CO2 footprint.", "How it works"]
    let description = ["Practiced consistently, this simple method will show you within a fairly short period of time, maybe two or three years, where your strengths lie—and this is the most important thing to know.", "Whenever you make a key decision or take a key action, write down what you expect will happen. Nine or 12 months later, compare the actual results with your expectations." ]

    var myCo2State: Co2State = Co2State(currentCo2State: 20.0)

    var body: some View {
        // MARK: headline

    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(toggle: true)
    }
}
