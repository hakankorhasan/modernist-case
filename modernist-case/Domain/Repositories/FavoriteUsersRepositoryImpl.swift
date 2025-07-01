//
//  FavoriteUsersRepositoryImpl.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

protocol FavoriteUsersRepository {
    func add(user: User)
    func remove(userId: Int)
    func isFavorite(userId: Int) -> Bool
    func getAllFavorites() -> [User]
}

final class FavoriteUsersRepositoryImpl: FavoriteUsersRepository {

    private let localDataSource: FavoriteUserLocalDataSource

    static let shared = FavoriteUsersRepositoryImpl(localDataSource: FavoriteUserLocalDataSource.shared)
    
    init(localDataSource: FavoriteUserLocalDataSource = FavoriteUserLocalDataSource()) {
        self.localDataSource = localDataSource
    }

    func add(user: User) {
        localDataSource.add(user: user)
    }

    func remove(userId: Int) {
        localDataSource.remove(userId: userId)
    }

    func isFavorite(userId: Int) -> Bool {
        localDataSource.isFavorite(userId: userId)
    }

    func getAllFavorites() -> [User] {
        localDataSource.getAllFavorites().map {
            User(
                id: Int($0.id),
                name: $0.name,
                username: $0.username,
                email: $0.email,
                address: $0.address,
                phone: $0.phone,
                website: "",
                company: $0.company ?? Company(name: "", catchPhrase: "", bs: "")
            )
        }
    }
}
