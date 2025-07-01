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
        entity.id = Int64(user.id)
        entity.name = user.name
        entity.username = user.username
        entity.email = user.email
        entity.phone = user.phone
        entity.addressStreet = user.address.street
        entity.addressSuite = user.address.suite
        entity.addressCity = user.address.city
        entity.addressZip = user.address.zipcode
        entity.geoLat = user.address.geo.lat
        entity.geoLng = user.address.geo.lng
        
        do {
            try context.save()
            return true
        } catch {
            print("❌ Failed to save favorite user: \(error)")
            return false
        }
    }

    @discardableResult
    func remove(userId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteUserEntity> = FavoriteUserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", userId)

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

    func isFavorite(userId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteUserEntity> = FavoriteUserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", userId)

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
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
                User(
                    id: Int(entity.id),
                    name: entity.name ?? "",
                    username: entity.username ?? "",
                    email: entity.email ?? "",
                    address: Address(
                        street: entity.addressStreet ?? "",
                        suite: entity.addressSuite ?? "",
                        city: entity.addressCity ?? "",
                        zipcode: entity.addressZip ?? "",
                        geo: Geo(
                            lat: entity.geoLat ?? "",
                            lng: entity.geoLng ?? ""
                        )
                    ),
                    phone: entity.phone ?? "",
                    website: entity.website ?? "",
                    company: Company(
                        name: entity.companyName ?? "",
                        catchPhrase: entity.companyCatchPhrase ?? "",
                        bs: entity.companyBs ?? ""
                    )
                )
            }
        } catch {
            print("❌ Failed to fetch favorite users: \(error)")
            return []
        }
    }

}

