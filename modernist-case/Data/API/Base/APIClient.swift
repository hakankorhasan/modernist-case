//
//  APIClient.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import Combine

protocol APIClient {
    func request<T: Decodable>(_ endpoint: UserAPI, responseType: T.Type) -> AnyPublisher<T, NetworkError>
}
