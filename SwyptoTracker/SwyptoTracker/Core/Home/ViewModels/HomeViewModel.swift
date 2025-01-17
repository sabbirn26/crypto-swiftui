//
//  HomeViewModel.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 15/1/25.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    @Published var allCoins : [CoinModel] = []
    @Published var portfoliCoins: [CoinModel] = []
    @Published var searchText : String = ""
    
    private var dataService = CoinDataService()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        //            self.allCoins.append(DeveloperPreview.instance.coin)
        //            self.portfoliCoins.append(DeveloperPreview.instance.coin)
        //        }
        addSubcribers()
    }
    
    //updates allCoins
    func addSubcribers(){
        //        dataService.$allCoins
        //            .sink { [weak self] (returnedCoins) in
        //                self?.allCoins = returnedCoins
        //            }
        //            .store(in: &cancellable)
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
            
        }
    }
}
