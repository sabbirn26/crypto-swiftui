//
//  MarketDataService.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 18/1/25.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel?
    var marketDataSubscription: AnyCancellable?
    
    init(){
        getMarketData()
    }
    
    func getMarketData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
//                print(returnedGlobalData)
                self?.marketDataSubscription?.cancel()
            })
    }
}
