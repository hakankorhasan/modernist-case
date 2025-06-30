//
//  modernist_caseApp.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

@main
struct modernist_caseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
