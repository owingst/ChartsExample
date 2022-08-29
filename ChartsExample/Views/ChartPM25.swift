//
//  ChartPM25.swift
//  Home
//
//  Created by Tim Owings on 8/4/22.
//

import SwiftUI
import Charts

struct ChartPM25: View {
    
    var pm25: [O3]
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])
    
    var body: some View {
        
        if #available(iOS 16, *) {
            
            Chart {
                
                ForEach(pm25, id: \.self) { i in
                    LineMark(x: .value("Time",  chartDate(ts: i.day)),
                             y: .value("Value", i.avg))
                    .foregroundStyle(.white)
                }
            }.frame(width: UIScreen.screenWidth * 0.90, height: UIScreen.screenHeight * 0.35)
            
                .chartXAxis {
                  AxisMarks(values: .automatic) { value in
                    AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2, 4]))
                      .foregroundStyle(Color.red)
                      AxisValueLabel().foregroundStyle(Color.white)
                  }
                }
                .chartYAxis {
                    AxisMarks(position: .trailing, values: yValues) { value in
                        AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                            .foregroundStyle(Color.red)
                        AxisValueLabel().foregroundStyle(Color.white)
                    }
                }
                .chartPlotStyle { plotContent in
                    plotContent
                        .background(.blue)
                        .border(Color.blue, width: 2)
                }
            Spacer()
        }
    }
    
    var yValues: [Int] {
        
        var arr = [Int]()
        
        for y in pm25 {
            arr.append(y.avg)
        }

        let yValues = stride(from: 0, to: Int(arr.max()!) + 3, by: 5).map { $0 }
        return yValues
    }
}
