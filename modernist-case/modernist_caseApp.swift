//
//  modernist_caseApp.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

@main
struct modernist_caseApp: App {

    var body: some Scene {
        WindowGroup {
            MainTabView(userVM: UsersViewModel())
        }
    }
}
