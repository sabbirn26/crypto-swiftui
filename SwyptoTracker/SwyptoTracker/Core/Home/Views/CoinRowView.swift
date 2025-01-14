//
//  CoinRowView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 14/1/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColumn : Bool
    
    var body: some View {
        
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.scndTextColor)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
            
            Spacer()
            if showHoldingColumn {
                VStack(alignment: .trailing){
                    Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
                        .bold()
                    Text((coin.currentHoldings ?? 0).asNumberString())
                }
                .foregroundStyle(Color.theme.accent)
            }
            VStack(alignment: .trailing){
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundStyle(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ?
                        Color.theme.grnColor :
                            Color.theme.redColor
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews : PreviewProvider {
    static var previews: some View{
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
    }
}
