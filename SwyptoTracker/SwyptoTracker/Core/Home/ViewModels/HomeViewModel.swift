//
//  HomeViewModel.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 15/1/25.
//

import Foundation

class HomeViewModel : ObservableObject {
    @Published var allCoins : [CoinModel] = []
    @Published var portfoliCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfoliCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
