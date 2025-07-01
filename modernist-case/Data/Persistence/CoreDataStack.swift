//
//  CoreDataStack.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "FavoriteUserEntity")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved Core Data error: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
}
