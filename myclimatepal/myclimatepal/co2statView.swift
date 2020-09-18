//
//  co2statView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

let co2val = 70.0
let co2max = 100.0
let co2progress = Double(co2val/co2max)

struct co2statView: View {
    var body: some View {
        VStack{
            ZStack{
                Image("earth-green").resizable()
                Image("earth-burning")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: CGFloat(200*co2progress), alignment: .bottomLeading)
                    
                    .clipped()
                    .offset(y: CGFloat(200-co2progress*100 - 100))
            }.frame(width: 200.0, height: 200.0).shadow(radius: 15)
                    Text(String(co2progress*100) + "% Co2")
        }
    }
}

struct co2statView_Previews: PreviewProvider {
    static var previews: some View {
        co2statView()
    }
}
    
