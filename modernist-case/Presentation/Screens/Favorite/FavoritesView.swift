//
//  FavoritesView.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel = FavoritesViewModel()) {
          _viewModel = StateObject(wrappedValue: viewModel)
      }
    
    var body: some View {
        VStack {
            Text("Favorites")
        }
        .onAppear {
            viewModel.fetchFavorites()
        }
        
    }
}

#Preview {
    FavoritesView(viewModel: FavoritesViewModel())
}
