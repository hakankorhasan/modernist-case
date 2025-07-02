//
//  UserDetailsViewModel.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

import Foundation
import Combine

final class UserDetailsViewModel: ObservableObject {
    
    @Published var isFavorite: Bool = false

    private var addFavoriteUseCase = AddFavoriteUserUseCaseImpl.shared
    private let removeFavoriteUseCase = RemoveFavoriteUserUseCaseImpl.shared
    private let isFavoriteUseCase = IsFavoriteUserUseCaseImpl.shared

    private var cancellables = Set<AnyCancellable>()
    private let user: User
    
    init(user: User) {
        self.user = user
        checkIfFavorite()
    }
    
    func toggleFavorite() {
        if isFavorite {
            removeFavoriteUseCase.execute(userId: user.id?.value ?? "")
                .sink { [weak self] in
                    self?.isFavorite = false
                }
                .store(in: &cancellables)
        } else {
            addFavoriteUseCase.execute(user: user)
                .sink { [weak self] in
                    self?.isFavorite = true
                }
                .store(in: &cancellables)
        }
    }
    
    private func checkIfFavorite() {
        isFavoriteUseCase.execute(userId: user.id?.value ?? "")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isFav in
                self?.isFavorite = isFav
            }
            .store(in: &cancellables)
    }
}
