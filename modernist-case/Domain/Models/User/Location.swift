//
//  Location.swift
//  modernist-case
//
//  Created by Hakan on 2.07.2025.
//
struct Location: Codable, Hashable {
    let street: Street?
    let city: String?
    let state: String?
    let country: String?
    let postcode: Int?
    let coordinates: Coordinates?
    let timezone: Timezone?
}
