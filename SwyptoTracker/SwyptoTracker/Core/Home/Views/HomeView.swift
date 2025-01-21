//
//  HomeView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/11/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortfolio: Bool = false //animate to the right
    
    @State private var showProtfolioView: Bool = false //show new sheet
    
    var body: some View {
        ZStack{
            Color.theme.bgColor
                .ignoresSafeArea()
                .sheet(isPresented: $showProtfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            VStack{
                homeViewHeader
                HomeStatView(showProtfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitle
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    protfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

extension HomeView {
    //MARK: View Part
    private var homeViewHeader : some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .onTapGesture {
                    if showPortfolio {
                        showProtfolioView.toggle()
                    }
                }
                .animation(.none)
                .background{
                    CircleBtnAnimationView(animate: $showPortfolio)
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180: 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList : some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
            }
        }
        .listStyle(.plain)
        .refreshable {
            vm.reloadCoinData()
        }
    }
    
    var protfolioCoinsList : some View {
        List {
            ForEach(vm.portfoliCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
            }
        }
        .listStyle(.plain)
        .refreshable {
            vm.reloadCoinData()
        }
    }
    
    var columnTitle : some View {
        HStack{
            HStack(spacing: 4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .cRank || vm.sortOptions == .cRankRev) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .cRank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOptions = vm.sortOptions == .cRank ? .cRankRev : .cRank
                }
            }
            
            Spacer()
            if showPortfolio{
                HStack(spacing: 4){
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOptions == .holdings || vm.sortOptions == .holdingRev) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOptions == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default){
                        vm.sortOptions = vm.sortOptions == .holdings ? .holdingRev : .holdings
                    }
                }
                
            }
            HStack(spacing: 4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(showPortfolio ? 0.0 : 1.0)
                    .opacity((vm.sortOptions == .price || vm.sortOptions == .priceRev) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOptions = vm.sortOptions == .price ? .priceRev : .price
                }
            }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.scndTextColor)
        .padding(.horizontal, 10)
    }
    
    
    //MARK: Methods
}

struct HomeView_Previews : PreviewProvider {
    static var previews: some View{
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}
