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
                Text("")
                    .frame(height: 150)
                
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(
                    columns: colmns,
                    alignment: .leading,
                    spacing: spacing,
                    pinnedViews: [],
                    content: {
                        ForEach(0..<6){_ in
                            StatisticView(stat: StatisticModel(title: "Demo Title", value: "Demo Value"))
                            
                        }
                    })
                
                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(
                    columns: colmns,
                    alignment: .leading,
                    spacing: spacing,
                    pinnedViews: [],
                    content: {
                        ForEach(0..<6){_ in
                            StatisticView(stat: StatisticModel(title: "Demo Title", value: "Demo Value"))
                            
                        }
                    })
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

struct DetailsView_Previews : PreviewProvider {
    static var previews: some View{
        NavigationView {
            DetailsView(coin: dev.coin)

        }
    }
}
