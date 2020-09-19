//
//  PieChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView : View {
    public var labels: [String]
    public var data: [Double]
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var formSize:CGSize
    public var dropShadow: Bool
    public var valueSpecifier:String
    public var colors: [String: Color] = ["Food": Color(hexString: "F2B705"), "Transport": Color(hexString: "025E73"), "Clothing": Color(hexString: "037F8C"), "Home": Color(hexString: "F2762E")]
    
    @State private var showValue = false
    @State private var currentValue: Double = 0 {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
                HapticFeedback.playSelection()
            }
        }
    }
    @State private var currentLabel: String = ""
    
    public init(labels: [String], data: [Double], title: String, legend: String? = nil, style: ChartStyle = Styles.pieChartStyleOne, form: CGSize? = ChartForm.medium, dropShadow: Bool? = true, valueSpecifier: String? = "%.1f"){
        self.labels = labels
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.formSize = form!
        if self.formSize == ChartForm.large {
            self.formSize = ChartForm.extraLarge
        }
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.style.backgroundColor)
                .cornerRadius(20)
                .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 12 : 0)
            VStack(alignment: .leading){
                HStack{
                    if(!showValue){
                        Text(self.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(self.style.textColor)
                    } else {
                        //Text("\(self.currentValue, specifier: self.valueSpecifier)")
                        Text("\(self.currentLabel): \(Int(round(self.currentValue))) kgCo2")
                            .font(.title)
                            .bold()
                            .foregroundColor(self.style.textColor)
                    }
                    //Spacer()
                    
                    /*Image(systemName: "chart.pie.fill")
                        .imageScale(.large)
                        .foregroundColor(self.style.legendTextColor)*/
                }.padding()
                HStack {
                    Spacer()
                    PieChartRow(labels: labels, data: data, backgroundColor: self.style.backgroundColor, accentColor: self.style.accentColor, colors: colors, showValue: $showValue, currentValue: $currentValue, currentLabel: $currentLabel)
                        .foregroundColor(self.style.accentColor)
                        .frame(width: 130, height: 130)
                        //.padding(.trailing)
                        //.offset(y:-15)//padding(12).
                    Spacer()
                    VStack(alignment: .leading) {
                        ForEach((0..<data.count), id: \.self) {
                            let x = $0
                            let size: CGFloat = 15
                            if data[x] > 0 {
                                HStack {
                                    Circle()
                                        .foregroundColor(colors[labels[x]])
                                        .frame(width: size, height: size)
                                    Text("\(labels[x]) (\(Int(round(data[x] / data.reduce(0, +) * 100)))%)")
                                        .font(.system(size: size))
                                }
                            }
                        }
                    }
                    Spacer()
                    //.padding()
                }
                Spacer()

                if(self.legend != nil) {
                    /*Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.style.legendTextColor)
                        //.padding()
                        .opacity(0)*/
                }
                
            }
        }.frame(width: self.formSize.width, height: self.formSize.height)
    }
}

#if DEBUG
struct PieChartView_Previews : PreviewProvider {
    static var previews: some View {
        PieChartView(labels: ["56","78","53","65","54"], data:[56,78,53,65,54], title: "Title", legend: "Legend")
    }
}
#endif
