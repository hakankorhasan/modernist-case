//
//  UserRepository.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

protocol UserRepository {
    func fetchUsers() async throws -> [RandomUser]
}

final class UserRepositoryImpl: UserRepository {

    static let shared = UserRepositoryImpl(remote: UserRemoteDataSource.shared)
    
    private let remote: UserRemoteDataSource
    
    init(remote: UserRemoteDataSource) {
        self.remote = remote
    }
    
    func fetchUsers() async throws -> [RandomUser] {
        try await remote.fetchUsers()
    }
    
}
