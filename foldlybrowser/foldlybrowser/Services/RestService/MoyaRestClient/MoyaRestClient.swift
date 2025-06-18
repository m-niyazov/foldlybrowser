//
//  MoyaAPIClient.swift
//  ProSport
//
//  Created by m.TapticGroup on 27.03.2025.
//

import Moya
import Foundation

final class MoyaRestClient<Target: TargetType>: RestClient {
    typealias Endpoint = Target

    private lazy var provider: MoyaProvider<Target> = .init()

    private var options: NetworkOptions

    init(options: [NetworkOptions.Options] = []) {
        self.options = NetworkOptions(options: options)
    }

    func load<T: Decodable>(from endpoint: Target, success: @escaping (T) -> Void, failure: @escaping (NetworkError) -> Void) {
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedObject = try jsonDecoder.decode(T.self, from: response.data)
                    success(decodedObject)
                } catch {
                    let errorString = String(data: response.data, encoding: .utf8)
                    failure(.unableToDecode)
                }
            case .failure(let error):
                if error.response?.statusCode == 401 {
                    failure(.unauthorized)
                } else if error.response?.statusCode == 403 {
                    failure(.tokenExpired)
                } else if let response = error.response {
                    self.decodeClientError(data: response.data, failureCallback: failure)
                } else if error.response == nil {
                    failure(.noInternetConnection)
                } else {
                    failure(.serverError)
                }
            }
        }
    }

    func loadData(from endpoint: Target, success: @escaping (Data) -> Void, failure: @escaping (NetworkError) -> Void) {
         provider.request(endpoint) { result in
             switch result {
             case .success(let response):
                 success(response.data)
             case .failure(let error):
                 print("🌐 Network error:", error)
                 failure(.serverError)
             }
         }
     }
}
