//
//  Login.swift
//  modernist-case
//
//  Created by Hakan on 2.07.2025.
//

struct Login: Codable, Hashable {
    let uuid: String?
    let username: String?
    let password: String?
    let salt: String?
    let md5: String?
    let sha1: String?
    let sha256: String?
}
