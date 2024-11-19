//
//  HomeView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/11/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.bgColor
                .ignoresSafeArea()
            
            VStack{
                homeViewHeader
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
    
    
    //MARK: Methods
}

#Preview {
    NavigationView{
        HomeView()
            .navigationBarHidden(true)
    }
}
