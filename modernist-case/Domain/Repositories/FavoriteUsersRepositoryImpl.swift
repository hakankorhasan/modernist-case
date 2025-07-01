//
//  FavoriteUsersRepositoryImpl.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

protocol FavoriteUsersRepository {
    func add(user: User)
    func remove(userId: String)
    func isFavorite(userId: String) -> Bool
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

    func remove(userId: String) {
        localDataSource.remove(userIdValue: userId)
    }

    func isFavorite(userId: String) -> Bool {
        localDataSource.isFavorite(userIdValue: userId)
    }

    func getAllFavorites() -> [User] {
        let entities = localDataSource.getAllFavorites()
        
        return entities.map { entity in
            User(
                gender: entity.gender ?? "",
                name: Name(
                    title: entity.name?.title ?? "",
                    first: entity.name?.first ?? "",
                    last: entity.name?.last ?? ""
                ),
                location: Location(
                    street: Street(
                        number: entity.location?.street?.number,
                        name: entity.location?.street?.name ?? ""
                    ),
                    city: entity.location?.city ?? "",
                    state: entity.location?.state ?? "",
                    country: entity.location?.country ?? "",
                    postcode: entity.location?.postcode,
                    coordinates: Coordinates(
                        latitude: entity.location?.coordinates?.latitude ?? "",
                        longitude: entity.location?.coordinates?.longitude ?? ""
                    ),
                    timezone: Timezone(
                        offset: entity.location?.timezone?.offset ?? "",
                        description: entity.location?.timezone?.description ?? ""
                    )
                ),
                email: entity.email ?? "",
                login: Login(
                    uuid: entity.login?.uuid ?? "",
                    username: entity.login?.username ?? "",
                    password: entity.login?.password ?? "",
                    salt: entity.login?.salt ?? "",
                    md5: entity.login?.md5 ?? "",
                    sha1: entity.login?.sha1 ?? "",
                    sha256: entity.login?.sha256 ?? ""
                ),
                dob: DateInfo(
                    date: entity.dob?.date ?? "",
                    age: entity.dob?.age
                ),
                registered: DateInfo(
                    date: entity.registered?.date ?? "",
                    age: entity.registered?.age
                ),
                phone: entity.phone ?? "",
                cell: entity.cell ?? "",
                id: ID(
                    name: entity.id?.name ?? "",
                    value: entity.id?.value
                ),
                picture: Picture(
                    large: entity.picture?.large ?? "",
                    medium: entity.picture?.medium ?? "",
                    thumbnail: entity.picture?.thumbnail ?? ""
                ),
                nat: entity.nat ?? ""
            )
        }
    }
}
