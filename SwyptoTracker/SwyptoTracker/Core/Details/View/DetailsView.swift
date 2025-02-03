//
//  DetailsView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 22/1/25.
//

import SwiftUI

struct DetailsLoadingView : View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailsView(coin: coin)
            }
        }
    }
}

struct DetailsView: View {
    @StateObject private var vm: DetailsViewModel
    private let colmns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private var spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailsViewModel(coin: coin))
//        print("Init Details View for -----> \(coin.name)")
    }
    var body: some View {
        ScrollView{
            VStack{
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack{
                    overviewTitle
                    Divider()
                    
                    ZStack{
                        if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                            Text(coinDescription)
                                .font(.caption)
                                .foregroundStyle(Color.theme.scndTextColor)
                        }
                    }
                    
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                }
                .padding()
            }
            
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationImageAndText
            }
        }
    }
}

struct DetailsView_Previews : PreviewProvider {
    static var previews: some View{
        NavigationView {
            DetailsView(coin: dev.coin)

        }
    }
}

extension DetailsView {
    //MARK: VIEW PART
    private var overviewTitle : some View {
            Text("Overview")
                .font(.title)
                .bold()
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid : some View {
        LazyVGrid(
            columns: colmns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStat){ stat in
                    StatisticView(stat: stat)
                    
                }
            })
    }
    
    private var additionalTitle : some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalGrid : some View {
        LazyVGrid(
            columns: colmns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStat){ stat in
                    StatisticView(stat: stat)
                    
                }
            })
    }
    
    private var navigationImageAndText : some View {
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.scndTextColor)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    //MARK: METHOD
}
