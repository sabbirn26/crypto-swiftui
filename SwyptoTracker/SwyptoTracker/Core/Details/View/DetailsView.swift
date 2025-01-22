//
//  DetailsView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 22/1/25.
//

import SwiftUI

struct DetailsLoadingView : View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailsView(coin: coin)
            }
        }
    }
}

struct DetailsView: View {
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Init Details View for -----> \(coin.name)")
    }
    var body: some View {
            Text(coin.name)
    }
}

struct DetailsView_Previews : PreviewProvider {
    static var previews: some View{
        DetailsView(coin: dev.coin)
    }
}
