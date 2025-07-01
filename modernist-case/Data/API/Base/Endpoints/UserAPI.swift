//
//  UserAPI.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import Foundation

enum UserAPI {
    case getUsers(page: Int, results: Int, seed: String)
}

extension UserAPI {
    var path: String {
        switch self {
        case .getUsers:
            return "/api/"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var urlRequest: URLRequest {
        var components = URLComponents(string: APIConfig.baseURL + path)!
        
        switch self {
        case let .getUsers(page, results, seed):
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "results", value: "\(results)"),
                URLQueryItem(name: "seed", value: seed)
            ]
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }
}

