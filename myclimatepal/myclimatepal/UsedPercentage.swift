//
//  UsedPercentage.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 19.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct UsedPercentage: View {
    @EnvironmentObject var co2State: Co2State

    var co2progress: Double {
        get {return Double(self.co2State.currentCo2State/self.co2State.co2max)}
    }

    var cappedCo2progress: Double {
        get {
            return min(co2progress, 1.0)
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 360, height: 400, alignment: .center)
                .shadow(radius: 8)
            VStack {
                Text("Todays Emissions").bold().font(.title)
                ZStack {
                    Image("earth-green").resizable()
                    Image(co2progress >= 2 ? "death-star" : "earth-burning")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: CGFloat(200*cappedCo2progress), alignment: .bottomLeading)
                        .clipped()
                        .offset(y: CGFloat(200-cappedCo2progress*100 - 100))
                }.frame(width: 200.0, height: 200.0).shadow(radius: 15)
                HStack {
                    Text(String(Int(co2progress*100)) + " %")
                    ZStack {
                        Image(systemName: "cloud.fill").font(.system(size: 60)).offset(y: -5)
                        Text("Co2").colorInvert()
                    }
                    Text("of daily limit")

                }
                .padding()
                .font(.title)
            }
        }
    }
}

struct UsedPercentage_Previews: PreviewProvider {
    static var previews: some View {
        UsedPercentage().environmentObject(Co2State(currentCo2State: 10.0))
    }
}
