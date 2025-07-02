//
//  FetchUsersUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import Foundation
import Combine

protocol FetchUsersUseCase {
    func execute() -> AnyPublisher<[User], NetworkError>
}

final class FetchUsersUseCaseImpl: FetchUsersUseCase {
    
    static let shared = FetchUsersUseCaseImpl(userRepository: UserRepositoryImpl.shared)
    
    private let userRepository: UserRepository
    
    private init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() -> AnyPublisher<[User], NetworkError> {
        return userRepository.fetchUsers()
    }
}


