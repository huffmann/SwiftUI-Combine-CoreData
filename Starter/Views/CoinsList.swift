//
//  CoinsList.swift
//  Starter
//
//  Created by Xumak on 30/09/20.
//

import SwiftUI

struct CoinsList: View {
    
    @ObservedObject private var viewModel: CoinListViewModel = CoinListViewModel()
    var body: some View {
        
        NavigationView() {
            
            List(viewModel.coinViewModels, id: \.self) { coinViewModel in
                
                HStack {
                    Text(coinViewModel.displayText).font(.body)
                }
            }.onAppear{
                viewModel.fetchCoins()
            }.navigationTitle("Cyrpto Currencies")
        }
    }
}
//
//struct CoinsList_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinsList()
//    }
//}
