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
            let treeRange = Int(100*co2State.currentCo2State/co2State.co2max+1)

        if treeRange > 1 {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 360, height: 240, alignment: .center)
                    .shadow(radius: 8)
                VStack {
                    Text(String(co2State.treeOffsetNum) + " Trees living for one day would offset your emissions of today")
                        .font(.body).bold()
                        .frame(width: 300)
                        .offset(x: -20, y: -20)
                    ZStack {
                        ForEach((0...treeRange), id: \.self) {
                            Text(String($0)).opacity(0.0)
                            if $0 > 0 {
                                Image("tree-" + String(Int.random(in: 0...(($0 > 3) ? 4 : 3))))
                                    .offset(x: CGFloat(Int.random(in: -130...130)), y: CGFloat(($0 > 100 ? 50 : $0/2)-15))
                            }
                        }
                    }
            }
        }.padding(.bottom)
        } else {
            EmptyView()
        }
    }
}

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeView()
    }
}
