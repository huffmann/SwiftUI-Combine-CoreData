//
//  Service.swift
//  Starter
//
//  Created by Xumak on 24/09/20.
//

import Foundation
import Combine

struct ServiceConstants {
    static let baseURL = "api.coinranking.com"
}

struct ServicePath {
    static let coins = "/v1/public/coins"
}

final class Service<T: Decodable> {
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "\(ServiceConstants.baseURL)"
        components.path = "\(ServicePath.coins)"
        components.queryItems = [ URLQueryItem(name: "base", value: "USD"),
                                  URLQueryItem(name: "timePeriod", value: "24h")
        ]
        return components
    }
    
    func request() -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct ServiceResponseObject<T: Decodable>: Decodable {
    let status: String
    let data: ServiceData<T>
}

struct ServiceData<T: Decodable>: Decodable {
    let coins: [T]
}
