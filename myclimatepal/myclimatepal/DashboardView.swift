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
    
    var co2progress: Double {
        get {return Double(self.co2State.currentCo2State/self.co2State.co2max)}
    }
    
    var cappedCo2progress : Double {
        get {
            return min(co2progress, 1.0)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack{
                Text("Co2 Stats")
                    .font(.largeTitle)
                    .bold()
                    .frame(width: 400, alignment: .top)
                    .padding(.top)
                    .padding()
                Spacer().frame(minHeight: 20, maxHeight: 80)
                
                ZStack{
                    Image("earth-green").resizable()
                    Image(co2progress >= 2 ? "death-star" : "earth-burning")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: CGFloat(200*cappedCo2progress), alignment: .bottomLeading)
                        .clipped()
                        .offset(y: CGFloat(200-cappedCo2progress*100 - 100))
                }.frame(width: 200.0, height: 200.0).shadow(radius: 15)
                
                Spacer().frame(minHeight: 20, maxHeight: 80)
                
                HStack{
                    Text(String(Int(co2progress*100)) + " %")
                    ZStack {
                        Image(systemName: "cloud.fill").font(.system(size: 60)).offset(y: -5)
                        Text("Co2").colorInvert()
                    }
                    Text("used")
                    
                }
                .padding()
                .font(.title)
                
                DayGraph().environmentObject(co2State).frame(height: 800)
            }
        }
    }
}



struct co2statView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(Co2State(currentCo2State: 50))
    }
}
    
