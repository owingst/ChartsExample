//
//  ContentView.swift
//  ChartsExample
//
//  Created by Tim Owings on 8/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var ws = Webservice()
    @State private var pm10: Double =  1.0
    @State private var pm25: Double =  1.0
    @State private var minValue: Double =  1.0
    @State private var maxValue: Double =  500.0
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])
    @State var showingGraph: Bool = false
    @State var whichGraph: String = ""
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            VStack {
                Spacer().frame(width: 75, height: 100)
                Text("Air Quality").font(.largeTitle).foregroundColor(.white)
            }
            
            HStack(spacing: 50) {
                
                VStack {
                    Text("PM 2.5  µg/m3").bold()
                        .modifier(Wtx(fontName: "NewYork", fontSize: 20.0, fgColor: .white, pad: 4))
                    
                    Spacer().frame(width: 75, height: 35)
                    
                    Gauge(value: pm25, in: minValue...maxValue) {
                        
                        VStack {
                            Text("\(pm25, specifier: "%.1f")").bold()
                                .modifier(Wtx(fontName: "NewYork", fontSize: 12.0, fgColor: .white, pad: 4))
                            
                        }
                    } currentValueLabel: {
                        
                        Text("\(pm25, specifier: "%.1f")")
                            .modifier(FontSize(fontSize: 18, fgColor: .blue))
                    } minimumValueLabel: {
                        Text("1")
                            .modifier(FontSize(fontSize: 8, fgColor: .green))
                    } maximumValueLabel: {
                        Text("500")
                            .modifier(FontSize(fontSize: 8, fgColor: .red))
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(gradient)
                    .scaleEffect(1.8)
                    .onTapGesture {
                        //print("pm25 gauge clicked")
                        whichGraph = "pm25"
                        showingGraph = true
                    }
                }
                
                VStack {
                    
                    Text("PM 10  µg/m3").bold()
                        .modifier(Wtx(fontName: "NewYork", fontSize: 20.0, fgColor: .white, pad: 4))
                    
                    Spacer().frame(width: 75, height: 35)
                    
                    Gauge(value: pm10, in: minValue...maxValue) {
                        
                        VStack {
                            Text("\(pm10)").bold()
                                .modifier(Wtx(fontName: "NewYork", fontSize: 12.0, fgColor: .white, pad: 4))
                            
                        }
                    } currentValueLabel: {
                        Text("\(pm10, specifier: "%.1f")")
                            .modifier(FontSize(fontSize: 18, fgColor: .blue))
                    } minimumValueLabel: {
                        Text("1")
                            .modifier(FontSize(fontSize: 8, fgColor: .green))
                    } maximumValueLabel: {
                        Text("500")
                            .modifier(FontSize(fontSize: 8, fgColor: .red))
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(gradient)
                    .scaleEffect(1.8)
                    .onTapGesture {
                        //print("pm10 gauge clicked")
                        whichGraph = "pm10"
                        showingGraph = true
                    }
                }
                
            }
            Spacer().frame(width: 75, height: 50)
            if showingGraph {
                
                if (whichGraph == "pm10") {
                    let (pm10, _) = ws.getAirQualityForecast()
                    Spacer().frame(width: 75, height: 50)
                    VStack(alignment: .center) {
                        Text("PM10 Graph View")
                            .modifier(Wtx(fontName: "NewYork", fontSize: 18.0, fgColor: .white, pad: 4))
                        Spacer().frame(width: 75, height: 25)
                        ChartPM10(pm10: pm10)
                    }
                } else if (whichGraph == "pm25") {
                    
                    let (_, pm25) = ws.getAirQualityForecast()
                    Spacer().frame(width: 75, height: 50)
                    VStack(alignment: .center) {
                        Text("PM25 Graph View")
                            .modifier(Wtx(fontName: "NewYork", fontSize: 18.0, fgColor: .white, pad: 4))
                        Spacer().frame(width: 75, height: 25)
                        ChartPM25(pm25: pm25)
                    }
                }
            } else {
                Text("No Graph")
                    .modifier(Wtx(fontName: "NewYork", fontSize: 18.0, fgColor: .white, pad: 4))
            }
            Spacer()
        }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight).edgesIgnoringSafeArea(.all).background(.black) //end top vstack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
