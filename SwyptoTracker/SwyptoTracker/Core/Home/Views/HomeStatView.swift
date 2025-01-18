//
//  HomeStatView.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 18/1/25.
//

import SwiftUI

struct HomeStatView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @Binding var showProtfolio : Bool
    var body: some View {
        HStack{
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showProtfolio ? .trailing : .leading)
    }
}

struct HomeStatView_Previews : PreviewProvider {
    static var previews: some View{
        HomeStatView(showProtfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
