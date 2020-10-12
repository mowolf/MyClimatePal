//
//  SourceView.swift
//  myclimatepal
//
//  Created by Moritz Wolf on 07.10.20.
//  Copyright © 2020 myclimatepal. All rights reserved.
//

import SwiftUI

class Source {
    let url: String
    let title: String
    let author: String
    let year: String
    
    init(url: String, title: String, author: String, year: String) {
        self.url = url
        self.title = title
        self.author = author
        self.year = year
    }
}

struct SourceView: View {
    var sourceID: Int
    @Binding var isPresented: Bool
    
    // MARK: Sources
    let sources = [
        Source(url: "https://eprints.lancs.ac.uk/id/eprint/79432/4/1_s2.0_S0959652616303584_main.pdf", title: "Systematic review of greenhouse gas emissions for different fresh food categories", author: "Stephen Clune, Enda Crossin, Karli Verghese", year: "2016"),
        Source(url: "https://www.eea.europa.eu/data-and-maps/daviz/co2-emission-intensity-5#tab-googlechartid_chart_11_filters=%7B%22rowFilters%22%3A%7B%7D%3B%22columnFilters%22%3A%7B%22pre_config_ugeo%22%3A%5B%22European%20Union%20(current%20composition)%22%5D%7D%7D", title: "CO2 emission intensity", author: "European Environmental Agency", year: "2018"),
        Source(url: "https://data.worldbank.org/indicator/EN.ATM.CO2E.PC?locations=1W", title: "The average world CO2eqkg/capita per day ~13.6 Co2eqkg", author: "The World Bank", year: "2012")
    ]
    
    var body: some View {
        VStack (content: {
            Text("📃")
                .font(.system(size: 140))
                .padding()
                        
            Text(sources[sourceID].title + " - " + sources[sourceID].year)
                .font(.largeTitle)
                .bold()
                .padding()
            
            
            Text(sources[sourceID].author)
                .font(.body)
                .bold()
                .padding()
            
            Link("view source online",
                 destination: URL(string: sources[sourceID].url)!)
                .foregroundColor(.blue)
                .font(.body)
                .padding()
            
        })
        
        Spacer()
        
        Divider()
        Button("Close", action: {isPresented = false}).font(.body)
    }
}
