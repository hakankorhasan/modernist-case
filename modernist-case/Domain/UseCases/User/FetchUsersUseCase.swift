//
//  FetchUsersUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import Foundation

protocol FetchUsersUseCase {
    func execute() async throws -> [User]
}

final class FetchUsersUseCaseImpl: FetchUsersUseCase {
    
    static let shared = FetchUsersUseCaseImpl(userRepository: UserRepositoryImpl.shared)
    
    private let userRepository: UserRepository
    
    private init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> [User] {
        return try await userRepository.fetchUsers()
    }
}


