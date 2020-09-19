//
//  PieChartRow.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartRow: View {
    var labels: [String]
    var data: [Double]
    var backgroundColor: Color
    var accentColor: Color
    var colors: [String: Color] = [:]
    var slices: [PieSlice] {
        var tempSlices: [PieSlice] = []
        var lastEndDeg: Double = 0
        let maxValue = data.reduce(0, +)
        var i = 0
        for slice in data {
            let normalized: Double = Double(slice)/Double(maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            let label = labels[i]
            let color = colors[label] ?? self.accentColor
            //let color = label == "Food" ? colors[0] : label == "Transport" ? colors[1] : label == "Clothing" ? colors[2] : label == "House" ? colors[3] : self.accentColor
            tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: slice, label: labels[i], normalizedValue: normalized, color: color))
            i += 1
        }
        return tempSlices
    }

    @Binding var showValue: Bool
    @Binding var currentValue: Double
    @Binding var currentLabel: String

    @State private var currentTouchedIndex = -1 {
        didSet {
            if oldValue != currentTouchedIndex {
                showValue = currentTouchedIndex != -1
                currentValue = showValue ? slices[currentTouchedIndex].value : 0
                currentLabel = showValue ? slices[currentTouchedIndex].label : ""
            }
        }
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<self.slices.count) { i in
                    PieChartCell(rect: geometry.frame(in: .local), startDeg: self.slices[i].startDeg, endDeg: self.slices[i].endDeg, index: i, backgroundColor: self.backgroundColor, accentColor: self.slices[i].color) // self.accentColor
                        .scaleEffect(self.currentTouchedIndex == i ? 1.1 : 1)
                        .animation(Animation.spring())
                }
            }
            .gesture(DragGesture()
                        .onChanged({ value in
                            let rect = geometry.frame(in: .local)
                            let isTouchInPie = isPointInCircle(point: value.location, circleRect: rect)
                            if isTouchInPie {
                                let touchDegree = degree(for: value.location, inCircleRect: rect)
                                self.currentTouchedIndex = self.slices.firstIndex(where: { $0.startDeg < touchDegree && $0.endDeg > touchDegree }) ?? -1
                            } else {
                                self.currentTouchedIndex = -1
                            }
                        })
                        .onEnded({ _ in
                            self.currentTouchedIndex = -1
                        }))
        }
    }
}

#if DEBUG
struct PieChartRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            /*PieChartRow(data:[8,23,54,32,12,37,7,23,43], backgroundColor: Color(red: 252.0/255.0, green: 236.0/255.0, blue: 234.0/255.0), accentColor: Color(red: 225.0/255.0, green: 97.0/255.0, blue: 76.0/255.0), showValue: Binding.constant(false), currentValue: Binding.constant(0))
                .frame(width: 100, height: 100)
            PieChartRow(data:[0], backgroundColor: Color(red: 252.0/255.0, green: 236.0/255.0, blue: 234.0/255.0), accentColor: Color(red: 225.0/255.0, green: 97.0/255.0, blue: 76.0/255.0), showValue: Binding.constant(false), currentValue: Binding.constant(0))
                .frame(width: 100, height: 100)*/
        }
    }
}
#endif
