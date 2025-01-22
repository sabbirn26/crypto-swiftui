//
//  DetailsView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 22/1/25.
//

import SwiftUI

struct DetailsView: View {
    @Binding var coin: CoinModel?
    init(coin: Binding<CoinModel?>) {
        self._coin = coin
        print("Init Details View for -----> \(coin.wrappedValue?.name)")
    }
    var body: some View {
        Text(coin?.name ?? "")
    }
}

struct DetailsView_Previews : PreviewProvider {
    static var previews: some View{
        DetailsView(coin: .constant(dev.coin))
    }
}
