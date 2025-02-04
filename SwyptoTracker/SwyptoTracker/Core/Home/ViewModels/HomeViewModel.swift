//
//  HomeViewModel.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 15/1/25.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfoliCoins: [CoinModel] = []
    @Published var searchText : String = ""
    @Published var sortOptions : SortOptions = .holdings
    
    private var coinDataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    private var marketdataService = MarketDataService()
    
    private let portfolioDataService = PortfolioDataService()
    
    enum SortOptions {
        case cRank, cRankRev, holdings, holdingRev, price, priceRev
    }
    
    
    init() {
        addSubcribers()
    }
    
    
    func addSubcribers(){
        
        //updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOptions)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
        
        //update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else {
                    return
                }
                self.portfoliCoins = self.sortPortCoinIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellable)
        
        //updates marketData
        marketdataService.$marketData
            .combineLatest($portfoliCoins)
            .map(mapMarketGlobalData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellable)
        
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadCoinData(){
        coinDataService.getCoins()
        marketdataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins (text: String, coins: [CoinModel], sort: SortOptions ) -> [CoinModel]{
        var filteredCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &filteredCoins)
        return filteredCoins
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
    
    private func sortCoins(sort: SortOptions, coins: inout [CoinModel]) {
        switch sort {
        case .cRank, .holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .cRankRev, .holdingRev:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceRev:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortCoinIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        //will only sort by holding
        switch sortOptions {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingRev:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
            
        default:
            return coins
        }
    }
    
    private func mapAllCoinsToPortCoins(allCoins: [CoinModel], protfolioEntities: [PortfolioEntity]) -> [CoinModel]{
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = protfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapMarketGlobalData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel]{
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue =
        portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue =
        portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0.0) / 100
                let previousValue = currentValue / (1 + percentChange)
                
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = StatisticModel(title: "Protfolio Value", value:  portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
}
