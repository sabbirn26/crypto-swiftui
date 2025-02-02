//
//  ChartView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 2/2/25.
//

import SwiftUI

struct ChartView: View {
    let data: [Double]
    let maxY : Double
    let minY : Double
    let lineColor : Color
    
    init(coin: CoinModel){
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.grnColor : Color.theme.redColor
    }
    
    //Math Here - >
    // 300
    // 100
    // 3
    // 1 * 3 = 3
    // 2 * 3 = 6
    // 3 * 3 = 9
    // 100 * 3 = 300
    
    // 60,000 - max
    // 50,000 - min
    // yAxis = max - min = 60,000 - 50,000 = 10,000
    // 52,000 - data point
    // 52,000 - 50,000 = 2,000 / 10,000 = 20%
    
    var body: some View {
        chartSection
            .frame(height: 200)
            .background(
                
            )
    }
}

struct ChartView_Previews : PreviewProvider {
    static var previews: some View{
            ChartView(coin: dev.coin)
//            .frame(width: 100)
    }
}

extension ChartView {
    //MARK: VIEW PART
    private var chartSection : some View {
        GeometryReader {  geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }
    
}
