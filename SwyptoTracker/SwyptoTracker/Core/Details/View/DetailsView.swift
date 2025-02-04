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
    @State private var showFullDes: Bool = false
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
                    showDescriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    externalURLSection
                }
                .padding()
            }
        }
        .background(
            Color.theme.bgColor
                .ignoresSafeArea()
        )
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
                ForEach(vm.overviewStat) { stat in
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
    
    private var showDescriptionSection : some View {
        ZStack{
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading){
                    Text(coinDescription)
                        .lineLimit(showFullDes ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.scndTextColor)
                    
                    Button(action: {
                        withAnimation(.easeInOut){
                            showFullDes.toggle()
                        }

                    }, label: {
                        Text(showFullDes ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var externalURLSection : some View {
        VStack(alignment: .leading, spacing: 10){
            if let websiteLinkString = vm.webURL,
               let url = URL(string: websiteLinkString) {
                HStack{
                    Image(systemName: "link.circle.fill")
                        .frame(width: 15, height: 15)
                    Link("Website", destination: url)
                }
                
            }
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                HStack {
                    Image(systemName: "link.circle")
                        .frame(width: 15, height: 15)
                    Link("Reddit", destination: url)
                }
            }
        }
        .font(.headline)
        .foregroundStyle(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: METHOD
}
