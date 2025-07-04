//
//  UserRepository.swift
//  modernist-case
//
//  Created by Hakan on 3.07.2025.
//

import Combine

protocol UserRepository {
    func fetchUsers() -> AnyPublisher<[User], NetworkError>
}
