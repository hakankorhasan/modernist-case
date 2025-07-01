//
//  NetworkService.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import Foundation

final class NetworkService: APIClient {
    
    static let shared = NetworkService()

    init() { }
    
    func request<T: Decodable>(_ endpoint: UserAPI, responseType: T.Type) async throws -> T {
        let request = endpoint.urlRequest
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ Decoding error: \(error)")
            print("📦 Raw JSON: \(String(data: data, encoding: .utf8) ?? "nil")")
            throw error
        }
    }

}
