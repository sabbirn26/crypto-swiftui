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
    }
    
    var protfolioCoinsList : some View {
        List {
            ForEach(vm.portfoliCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    var columnTitle : some View {
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
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
