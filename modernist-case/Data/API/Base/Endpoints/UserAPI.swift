//
//  UserAPI.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import Foundation

enum UserAPI {
    case getUsers
}

extension UserAPI {
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }

    var method: HTTPMethod {
        return .get
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: APIConfig.baseURL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
