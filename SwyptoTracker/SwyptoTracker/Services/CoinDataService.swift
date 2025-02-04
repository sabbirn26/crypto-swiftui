//
//  CoinDataService.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 15/1/25.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    init(){
        getCoins()
    }
    
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        
        coinSubscription = NetworkingManager.download(url: url) // goes to backgroud thread
            .decode(type: [CoinModel].self, decoder: JSONDecoder()) // decodes the data from the API
            .receive(on: DispatchQueue.main) // comes back to the main thread
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                print("<---------------- All coins from API ------------------> \n\(returnedCoins)")
                self?.coinSubscription?.cancel()
            })
    }
}  
