//
//  FavoriteUserLocalDataSource.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

import CoreData

final class FavoriteUserLocalDataSource {

    private let context: NSManagedObjectContext
    static let shared = FavoriteUserLocalDataSource()
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }

    // MARK: - Public Methods

    @discardableResult
    func add(user: User) -> Bool {
        let entity = FavoriteUserEntity(context: context)
        configureEntity(entity, from: user)
        
        do {
            try context.save()
            return true
        } catch {
            print("❌ [CoreData] Failed to save favorite user: \(error.localizedDescription)")
            return false
        }
    }

    @discardableResult
    func remove(userIdValue: String) -> Bool {
        let request: NSFetchRequest<FavoriteUserEntity> = FavoriteUserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "idValue == %@", userIdValue)

        do {
            if let entity = try context.fetch(request).first {
                context.delete(entity)
                try context.save()
                return true
            }
        } catch {
            print("❌ [CoreData] Failed to remove favorite user: \(error.localizedDescription)")
        }

        return false
    }

    func isFavorite(userIdValue: String) -> Bool {
        let request: NSFetchRequest<FavoriteUserEntity> = FavoriteUserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "idValue == %@", userIdValue)

        do {
            return try context.count(for: request) > 0
        } catch {
            print("❌ [CoreData] Failed to check favorite status: \(error.localizedDescription)")
            return false
        }
    }

    func getAllFavorites() -> [User] {
        let request: NSFetchRequest<FavoriteUserEntity> = FavoriteUserEntity.fetchRequest()

        do {
            let entities = try context.fetch(request)
            return entities.compactMap { makeUser(from: $0) }
        } catch {
            print("❌ [CoreData] Failed to fetch favorite users: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Private Helpers

    private func configureEntity(_ entity: FavoriteUserEntity, from user: User) {
        entity.username = user.login?.username
        entity.email = user.email
        entity.phone = user.phone
        entity.cell = user.cell
        entity.gender = user.gender

        entity.title = user.name?.title
        entity.firstName = user.name?.first
        entity.lastName = user.name?.last

        entity.pictureThumbnail = user.picture?.thumbnail
        entity.pictureLarge = user.picture?.large
        entity.pictureMedium = user.picture?.medium

        entity.idName = user.id?.name
        entity.idValue = user.id?.value ?? ""

        entity.streetNumber = Int64(user.location?.street?.number ?? 0)
        entity.streetName = user.location?.street?.name
        entity.city = user.location?.city
        entity.state = user.location?.state
        entity.country = user.location?.country
        entity.postcode = Int32(user.location?.postcode ?? 0)

        entity.latitude = user.location?.coordinates?.latitude
        entity.longitude = user.location?.coordinates?.longitude

        entity.timezoneOffset = user.location?.timezone?.offset ?? ""
        entity.timezoneDescription = user.location?.timezone?.description

        entity.birthDate = user.dob?.date
        entity.birthAge = Int16(user.dob?.age ?? 0)

        entity.registeredDate = user.registered?.date
        entity.registeredAge = Int16(user.registered?.age ?? 0)

        entity.nat = user.nat

        entity.uuid = user.login?.uuid
        entity.password = user.login?.password
        entity.salt = user.login?.salt
        entity.md5 = user.login?.md5
        entity.sha1 = user.login?.sha1
        entity.sha256 = user.login?.sha256
    }

    private func makeUser(from entity: FavoriteUserEntity) -> User {
        User(
            gender: entity.gender ?? "",
            name: Name(
                title: entity.title,
                first: entity.firstName,
                last: entity.lastName
            ),
            location: Location(
                street: Street(number: Int(entity.streetNumber), name: entity.streetName),
                city: entity.city,
                state: entity.state,
                country: entity.country,
                postcode: Int(entity.postcode),
                coordinates: Coordinates(latitude: entity.latitude, longitude: entity.longitude),
                timezone: Timezone(offset: entity.timezoneOffset, description: entity.timezoneDescription)
            ),
            email: entity.email ?? "",
            login: Login(
                uuid: entity.uuid,
                username: entity.username,
                password: entity.password,
                salt: entity.salt,
                md5: entity.md5,
                sha1: entity.sha1,
                sha256: entity.sha256
            ),
            dob: DateInfo(date: entity.birthDate, age: Int(entity.birthAge)),
            registered: DateInfo(date: entity.registeredDate, age: Int(entity.registeredAge)),
            phone: entity.phone ?? "",
            cell: entity.cell ?? "",
            id: ID(name: entity.idName, value: entity.idValue),
            picture: Picture(
                large: entity.pictureLarge,
                medium: entity.pictureMedium,
                thumbnail: entity.pictureThumbnail
            ),
            nat: entity.nat ?? ""
        )
    }
}
