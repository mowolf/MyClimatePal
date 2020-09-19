//
//  TreeView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 19.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct TreeView: View {
    @EnvironmentObject var co2State: Co2State

    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 360, height: 400, alignment: .center)
                .shadow(radius: 8)
        
            VStack {
                ForEach((1...10).reversed(), id: \.self) {
                    Text(String($0))
//                    Image("tree-" + String(Int.random(in: 0..<4))).offset(x: CGFloat(Int.random(in: -20...20)))
                    }
//                ForEach((1...Int(co2State.currentCo2State)), id: \.self) {
//                        Image("tree-0") //+ String(Int.random(in: 0..<4))).offset(x: CGFloat(Int.random(in: -20...20)))
//                    }
            }

            
        }
    }
}

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeView()
    }
}
