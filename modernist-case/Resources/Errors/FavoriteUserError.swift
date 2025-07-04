//
//  FavoriteUserError.swift
//  modernist-case
//
//  Created by Hakan on 3.07.2025.
//

enum FavoriteUserError: Error {
    case alreadyExists
    case saveFailed(String)
}
