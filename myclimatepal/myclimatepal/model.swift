//
//  model.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import Combine
import Foundation

//let co2val = 70.0
//currentCo2State = co2val/co2max


final class Co2State: ObservableObject {
    // MARK: Co2
    @Published var currentCo2State: Double = 0
    @Published var co2max = 100.0
    
    init(currentCo2State: Double = 0.0) {
        self.currentCo2State = currentCo2State
    }
}
