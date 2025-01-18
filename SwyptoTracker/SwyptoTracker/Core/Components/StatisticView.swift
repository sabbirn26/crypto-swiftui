//
//  StatisticView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 18/1/25.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.scndTextColor)
            
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            HStack(spacing: 4){
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                    
                                    
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle( (stat.percentageChange ?? 0) >= 0 ? Color.theme.grnColor : Color.theme.redColor)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews : PreviewProvider {
    static var previews: some View{
        StatisticView(stat: dev.stat3)
    }
}
