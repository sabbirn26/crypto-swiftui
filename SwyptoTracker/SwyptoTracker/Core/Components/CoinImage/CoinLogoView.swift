//
//  CoinLogoView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/1/25.
//

import SwiftUI

struct CoinLogoView: View {
    let coin : CoinModel
    
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.scndTextColor)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct CoinLogoView_Previews : PreviewProvider {
    static var previews: some View{
        CoinLogoView(coin: dev.coin)
    }
}
