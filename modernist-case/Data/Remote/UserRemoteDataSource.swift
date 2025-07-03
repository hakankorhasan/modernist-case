//
//  UserRemoteDataSource.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import Combine

final class UserRemoteDataSource {
    private let apiClient: APIClient

    static let shared = UserRemoteDataSource(apiClient: NetworkService.shared)

    init(apiClient: APIClient = NetworkService()) {
        self.apiClient = apiClient
    }
    
    func fetchUsers() -> AnyPublisher<[User], NetworkError> {
        return apiClient
            .request(.getUsers(page: 3, results: 10, seed: "abc"), responseType: UserResponse.self)
            .map { $0.results ?? [] }
            .eraseToAnyPublisher()
    }
}
