//
//  ChartPM10.swift
//  Home
//
//  Created by Tim Owings on 8/4/22.
//

import SwiftUI
import Charts

struct ChartPM10: View {
    
    var pm10: [O3]
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])
    
    var body: some View {
            
            Chart {
                
                ForEach(pm10, id: \.self) { i in
                    LineMark(x: .value("Time",  chartDate(ts: i.day)),
                             y: .value("Value", i.avg))
                    .foregroundStyle(.white)
                }
            }.frame(width: UIScreen.screenWidth * 0.90, height: UIScreen.screenHeight * 0.35)
                .chartPlotStyle { plotContent in
                    plotContent
                        .background(.blue)
                        .border(Color.blue, width: 2)
                }
            
                .chartYAxis {
                    AxisMarks(position: .trailing, values: yValues) { value in
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                            .foregroundStyle(Color.red)
                        AxisValueLabel().foregroundStyle(Color.white)
                    }
                }
            
                .chartXAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                            .foregroundStyle(Color.red)
                        AxisValueLabel().foregroundStyle(Color.white)
                    }
                }

            Spacer()
    }
    
    var yValues: [Int] {
        
        var arr = [Int]()
        
        for y in pm10 {
            arr.append(y.avg)
        }

        let yValues = stride(from: 0, to: Int(arr.max()!) + 3, by: 1).map { $0 }
        return yValues
    }
}

