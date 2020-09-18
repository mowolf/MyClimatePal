//
//  co2statView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 18.09.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI



struct co2statView: View {
    var body: some View {
        ZStack{
            Image("earth-green").resizable()
            Image("earth-burning").resizable().clipShape(Circle()).frame(width: 100, height: 100, alignment: .bottom)


        }.frame(width: 200.0, height: 200.0)
    }
}

struct co2statView_Previews: PreviewProvider {
    static var previews: some View {
        co2statView()
    }
}
