//
//  DetailsViewModel.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 23/1/25.
//

import Foundation
import Combine

class DetailsViewModel {
    private let coinDetailsService: CoinDetailsDataService
    private var cancellables = Set<AnyCancellable>()
    init(coin: CoinModel) {
        self.coinDetailsService = CoinDetailsDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        
        coinDetailsService.$coinDetails
            .sink { (returnedCoinDetails) in
                print("<----- Received coin details data. -----> \n\(String(describing: returnedCoinDetails))")
                
            }
            .store(in: &cancellables)
    }
}
