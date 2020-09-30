//
//  CoinListViewModel.swift
//  Starter
//
//  Created by Xumak on 30/09/20.
//

import Foundation
import Combine

class CoinListViewModel: ObservableObject {
    
    @Published var coinViewModels: [CoinViewModel] = [CoinViewModel]()
    
    private var service: Service = Service<ServiceResponseObject<Coin>>()
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = service.request().sink(receiveCompletion: { (response) in
            
            switch response {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
            
        }, receiveValue: { [weak self] (container) in
            self?.coinViewModels = container.data.coins.map { CoinViewModel($0)}
            print(self?.coinViewModels ?? "Failed to print")
        })
    }
}

struct CoinViewModel: Hashable {
    
    private var coin: Coin
    
    var name: String {
        return coin.name
    }
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        guard let price = Double(coin.price), let formattedPrice = formatter.string(from: NSNumber(value: price)) else {
            return ""
        }
        return formattedPrice
    }
    
    var displayText: String {
        return "\(name) - \(formattedPrice)"
    }
    
    init(_ coin: Coin) {
        self.coin = coin
    }
}


struct Coin: Decodable, Hashable {
    let name: String
    let price: String 
}
