//
//  UserRemoteDataSource.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

final class UserRemoteDataSource {
    private let apiClient: APIClient

    init(apiClient: APIClient = NetworkService()) {
        self.apiClient = apiClient
    }

    func fetchUsers() async throws -> [User] {
        return try await apiClient.request(.getUsers, responseType: [User].self)
    }
}
