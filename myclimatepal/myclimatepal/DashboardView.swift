//
//  co2statView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var Co2State: Co2State
    
    var co2progress: Double {
        get {return Double(self.Co2State.currentCo2State/self.Co2State.co2max)}
    }
    
    var cappedCo2progress : Double {
        get {
            return min(co2progress, 1.0)
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            Text("Co2 Stats").font(.largeTitle).bold()
            Spacer()
            ZStack{
                Image("earth-green").resizable()
                Image(co2progress >= 2 ? "death-star" : "earth-burning")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: CGFloat(200*cappedCo2progress), alignment: .bottomLeading)
                    .clipped()
                    .offset(y: CGFloat(200-cappedCo2progress*100 - 100))
            }.frame(width: 200.0, height: 200.0).shadow(radius: 15)
            
            Text(String(Int(co2progress*100)) + "% Co2 used").padding().font(.title)
            Spacer()
        }
    }
}

struct co2statView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(Co2State(currentCo2State: 50))
    }
}
    
