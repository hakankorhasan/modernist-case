//
//  UsersView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct UsersView: View {
    
    var usersViewModel = UsersViewModel() 
    
    var body: some View {
        VStack {
            UserCardView()
            
            Spacer()
        }
    }
}

#Preview {
    UsersView()
}
