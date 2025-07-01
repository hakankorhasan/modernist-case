//
//  User.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//
import Foundation

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String?
    let company: Company?
    
    init(id: Int, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company) {
          self.id = id
          self.name = name
          self.username = username
          self.email = email
          self.address = address
          self.phone = phone
          self.website = website
          self.company = company
      }
}

// MARK: - Address
struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat: String
    let lng: String
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

