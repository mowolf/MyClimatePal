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
    @State var isShowingLicense = false

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
                
                Button(action: {
                    isShowingLicense = true
                }, label: {
                    Text("License").foregroundColor(.gray).font(.system(size: 10))
                }).padding()
            }
        }.sheet(isPresented: $isShowingLicense) {
            ScrollView {
            VStack {
                Spacer().frame(minHeight: 10, idealHeight: 20, maxHeight: 20)
                Text("Licenses").font(.largeTitle).bold()
                Text("App Icon")
                Text("from Freepik from www.flaticon.com").font(.caption)
                Text("Chart View by App Pear")
                Text("Copyright (c) 2019 Andras Samu. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.").font(.caption).padding()
                Text("Fuse")
                Text("Copyright (c) 2017 Kirollos Risk <kirollos@gmail.com>Permission is hereby granted, free of charge, to any person obtaining a copyof this software and associated documentation files (the 'Software'), to dealin the Software without restriction, including without limitation the rightsto use, copy, modify, merge, publish, distribute, sublicense, and/or sellcopies of the Software, and to permit persons to whom the Software isfurnished to do so, subject to the following conditions:The above copyright notice and this permission notice shall be included inall copies or substantial portions of the Software.THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS ORIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THEAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHERLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS INTHE SOFTWARE.").font(.caption).padding()
            }
            }

            Spacer()
            
            Divider()
            Button("Close", action: {isShowingLicense = false}).font(.body)
        }
    }
}

struct co2statView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(Co2State(currentCo2State: 50))
    }
}
