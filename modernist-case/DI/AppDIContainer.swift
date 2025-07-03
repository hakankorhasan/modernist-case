//
//  AppDIContainer.swift
//  modernist-case
//
//  Created by Hakan on 4.07.2025.
//

final class AppDIContainer {
    
    static let shared = AppDIContainer()
    
    // MARK: - Data Sources
    private lazy var remoteDataSource: UserRemoteDataSource = .shared
    private lazy var localDataSource: FavoriteUserLocalDataSource = .shared

    // MARK: - Repositories
    lazy var userRepository: UserRepository = UserRepositoryImpl(remote: remoteDataSource)
    lazy var favoriteUserRepository: FavoriteUsersRepository = FavoriteUsersRepositoryImpl(localDataSource: localDataSource)
    
    // MARK: - Use Cases
    lazy var fetchUsersUseCase: FetchUsersUseCase = FetchUsersUseCaseImpl(userRepository: userRepository)
    lazy var addFavoriteUserUseCase: AddFavoriteUserUseCase = AddFavoriteUserUseCaseImpl(repository: favoriteUserRepository)
    lazy var removeFavoriteUserUseCase: RemoveFavoriteUserUseCase = RemoveFavoriteUserUseCaseImpl(repository: favoriteUserRepository)
    lazy var isFavoriteUserUseCase: IsFavoriteUserUseCase = IsFavoriteUserUseCaseImpl(repository: favoriteUserRepository)
    lazy var getAllFavoriteUsersUseCase: GetAllFavoriteUsersUseCase = GetAllFavoriteUsersUseCaseImpl(repository: favoriteUserRepository)
    
    // MARK: - ViewModel Factory
    @MainActor func makeUsersViewModel() -> UsersViewModel {
        return UsersViewModel(
            fetchUserUseCase: fetchUsersUseCase,
            addFavoriteUseCase: addFavoriteUserUseCase,
            removeFavoriteUseCase: removeFavoriteUserUseCase,
            getAllFavoritesUseCase: getAllFavoriteUsersUseCase,
        )
    }
    
    // MARK: - Init
    
    init() { }
}

