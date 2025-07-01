//
//  NetworkService.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(_ endpoint: UserAPI, responseType: T.Type) async throws -> T
}

final class NetworkService: APIClient {
    
    static let shared = NetworkService()

    init() { }
    
    func request<T: Decodable>(_ endpoint: UserAPI, responseType: T.Type) async throws -> T {
        let request = endpoint.urlRequest
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
