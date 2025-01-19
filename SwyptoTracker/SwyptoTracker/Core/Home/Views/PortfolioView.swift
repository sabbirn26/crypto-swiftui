//
//  PortfolioView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/1/25.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Protfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    XmarkButton() //button not working
                })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    HStack(spacing: 10){
                        Image(systemName: "checkmark")
                            .opacity(showCheckMark ? 1.0 : 0.0)
                        Button(action: {
                            saveBtnPressed()
                        }, label: {
                            Text("Save".uppercased())
                        })
                    }
                    .font(.headline)
                    .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
                    .onTapGesture {
                        print("<-------- Coined saved to the Protfolio! -------->")
                    }
                })
            })
        }
        
    }
}

struct ProtfolioView_Previews : PreviewProvider {
    static var previews: some View{
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    
    //MARK: View Parts
    
    private var coinLogoList : some View {
        ScrollView(.horizontal, showsIndicators: true, content: {
            LazyHStack(spacing: 20){
                ForEach(vm.allCoins){ coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(selectedCoin?.id == coin.id ? Color.theme.grnColor : Color.clear, lineWidth: 1)
                        )

                }
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text("\(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")")
            }
            Divider()
            HStack{
                Text("Amount holding:")
                Spacer()
                TextField("Ex.1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            HStack{
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    
    
    //MARK: Methods
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveBtnPressed() {
        guard let coin = selectedCoin else {return}
        
        //save to portfolio
        
        
        //show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            resetSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        })
    }
    
    private func resetSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
        quantityText = ""
    }
}
