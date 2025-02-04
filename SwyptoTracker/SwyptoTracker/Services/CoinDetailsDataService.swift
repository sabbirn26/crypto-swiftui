//
//  CoinDetailsDataService.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 23/1/25.
//

import Foundation
import Combine

class CoinDetailsDataService {
    @Published var coinDetails: CoinDetailsModel? = nil
    var coinDetailsSubscription: AnyCancellable?
    let coin : CoinModel
    init(coin: CoinModel){
        self.coin = coin
        getCoinsDetails()
    }
    
    func getCoinsDetails(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
        
        coinDetailsSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailsModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                print("<---------------- Coin:\(String(describing: self?.coin.id))'s Details from API ------------------> \n\(returnedCoinDetails)")
                self?.coinDetailsSubscription?.cancel()
            })
    }
}
