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

    @discardableResult
    func add(user: User) -> Bool {
        let entity = FavoriteUserEntity(context: context)
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
        
        entity.streetNumber = Int64(user.location?.street?.number ?? 12)
        entity.streetName = user.location?.street?.name
        entity.city = user.location?.city
        entity.state = user.location?.state
        entity.country = user.location?.country
        entity.postcode = Int32(user.location?.postcode ?? 123)
        
        entity.latitude = user.location?.coordinates?.latitude
        entity.longitude = user.location?.coordinates?.longitude
        
        entity.timezoneOffset = user.location?.timezone?.offset ?? ""
        entity.timezoneDescription = user.location?.timezone?.description
        
        entity.birthDate = user.dob?.date
        entity.birthAge = Int16(user.dob?.age ?? 12)
        
        entity.registeredDate = user.registered?.date
        entity.registeredAge = Int16(user.registered?.age ?? 12)
        
        entity.nat = user.nat
        
        entity.uuid = user.login?.uuid
        entity.password = user.login?.password
        entity.salt = user.login?.salt
        entity.md5 = user.login?.md5
        entity.sha1 = user.login?.sha1
        entity.sha256 = user.login?.sha256
        
        do {
            try context.save()
            return true
        } catch {
            print("❌ Failed to save favorite user: \(error)")
            return false
        }
    }


    @discardableResult
    func remove(userIdValue: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteUserEntity> = FavoriteUserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idValue == %@", userIdValue)

        do {
            if let result = try context.fetch(fetchRequest).first {
                context.delete(result)
                try context.save()
                return true
            }
        } catch {
            print("❌ Failed to remove favorite user: \(error)")
        }

        return false
    }

    func isFavorite(userIdValue: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteUserEntity> = FavoriteUserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idValue == %@", userIdValue)

        do {
            return try context.count(for: fetchRequest) > 0
        } catch {
            print("❌ Failed to check favorite user: \(error)")
            return false
        }
    }

    func getAllFavorites() -> [User] {
        let fetchRequest: NSFetchRequest<FavoriteUserEntity> = FavoriteUserEntity.fetchRequest()

        do {
            let entities = try context.fetch(fetchRequest)
            return entities.map { entity in
                let name = Name(
                    title: entity.title,
                    first: entity.firstName,
                    last: entity.lastName
                )
                let street = Street(
                    number: Int(entity.streetNumber),
                    name: entity.streetName
                )
                let coordinates = Coordinates(
                    latitude: entity.latitude,
                    longitude: entity.longitude
                )
                let timezone = Timezone(
                    offset: entity.timezoneOffset,
                    description: entity.timezoneDescription
                )
                let location = Location(
                    street: street,
                    city: entity.city,
                    state: entity.state,
                    country: entity.country,
                    postcode: Int(entity.postcode),
                    coordinates: coordinates,
                    timezone: timezone
                )
                let login = Login(
                    uuid: entity.uuid,
                    username: entity.username,
                    password: entity.password,
                    salt: entity.salt,
                    md5: entity.md5,
                    sha1: entity.sha1,
                    sha256: entity.sha256
                )
                let dob = DateInfo(
                    date: entity.birthDate,
                    age: Int(entity.birthAge)
                )
                let registered = DateInfo(
                    date: entity.registeredDate,
                    age: Int(entity.registeredAge)
                )
                let id = ID(
                    name: entity.idName,
                    value: entity.idValue
                )
                let picture = Picture(
                    large: entity.pictureLarge,
                    medium: entity.pictureMedium,
                    thumbnail: entity.pictureThumbnail
                )

                return User(
                    gender: entity.gender ?? "",
                    name: name,
                    location: location,
                    email: entity.email ?? "",
                    login: login,
                    dob: dob,
                    registered: registered,
                    phone: entity.phone ?? "",
                    cell: entity.cell ?? "",
                    id: id,
                    picture: picture,
                    nat: entity.nat ?? ""
                )
            }
        } catch {
            print("❌ Failed to fetch favorite users: \(error)")
            return []
        }
    }


}
