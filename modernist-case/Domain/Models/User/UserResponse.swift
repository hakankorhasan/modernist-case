//
//  UserResponse.swift
//  modernist-case
//
//  Created by Hakan on 2.07.2025.
//
struct UserResponse: Codable, Hashable {
    let results: [User]?
    let info: Info?
}

