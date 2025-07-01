//
//  User+Mock.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

import Foundation

extension User {
    static var mock: User {
        User(
            id: 1,
            name: "Ada Lovelace",
            username: "adal",
            email: "ada@history.dev",
            address: Address(
                street: "Babbage St.",
                suite: "Apt. 101",
                city: "London",
                zipcode: "12345",
                geo: Geo(lat: "51.5074", lng: "0.1278")
            ),
            phone: "123-456-7890",
            website: "lovelace.io",
            company: Company(
                name: "Analytical Engines",
                catchPhrase: "Revolutionizing calculation",
                bs: "compute-driven design"
            )
        )
    }

    static var mockList: [User] {
        [
            .mock,
            User(
                id: 2,
                name: "Alan Turing",
                username: "aturing",
                email: "alan@crypto.ai",
                address: Address(
                    street: "Enigma Rd.",
                    suite: "Suite B",
                    city: "Cambridge",
                    zipcode: "54321",
                    geo: Geo(lat: "52.2053", lng: "0.1218")
                ),
                phone: "098-765-4321",
                website: "turing.uk",
                company: Company(
                    name: "Universal Machines Inc.",
                    catchPhrase: "Decoding the future",
                    bs: "logic & computation"
                )
            )
        ]
    }
}

