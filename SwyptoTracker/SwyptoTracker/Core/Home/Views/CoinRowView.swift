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
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews : PreviewProvider {
    static var previews: some View{
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
            .previewLayout(.sizeThatFits)
    }
}

extension CoinRowView {
    private var leftColumn : some View {
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
        }
    }
    
    private var centerColumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightColumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith2Decimals())
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
}
