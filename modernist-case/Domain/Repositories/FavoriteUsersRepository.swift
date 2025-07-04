//
//  FavoriteUsersRepository.swift
//  modernist-case
//
//  Created by Hakan on 3.07.2025.
//
import Combine

protocol FavoriteUsersRepository {
    func add(user: User) -> AnyPublisher<Void, Never>
    func remove(userId: String)
    func isFavorite(userId: String) -> Bool
    func getAllFavorites() -> [User]
}
