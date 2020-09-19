//
//  MagnifierRect.swift
//  
//
//  Created by Samu András on 2020. 03. 04..
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: Double
    var valueSpecifier: String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var body: some View {
        ZStack {
		VStack {
            Text("\(self.currentNumber, specifier: valueSpecifier)").font(.system(size: 18, weight: .bold))
		Text("kg Co2").font(.system(size: 15))
}
                .offset(x: 0, y: -130)
                .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
            if self.colorScheme == .dark {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: self.colorScheme == .dark ? 2 : 0)
                    .frame(width: 60, height: 295)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 60, height: 305)
                    .foregroundColor(Color.white)
                    .shadow(color: Colors.LegendText, radius: 12, x: 0, y: 6 )
                    .blendMode(.multiply)
            }
        }
    }
}

struct MagnifierRect_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
