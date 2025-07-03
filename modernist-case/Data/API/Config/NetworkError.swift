//
//  NetworkError.swift
//  modernist-case
//
//  Created by Hakan on 2.07.2025.
//

import Foundation

enum NetworkError: Error {
    case urlError(URLError)
    case invalidData
    case badRequest(InternalError)
    case forbidden
    case notFound
    case selfNil // TODO: This should be a CodeError, not a NetworkError (nor a DomainError - has nothing to do with the app domain)
    case serverError
    case unauthorized
    case unknown(Error)
    case decodingError(DecodingError)
    case emptyData
    case requestAlreadyInProgress

    var localizedDescription: String {
        switch self {
        case .urlError(let error): return "\(error.localizedDescription)"
        case .invalidData: return "Invalid Data"
        case .badRequest(let error): return "\(error.message ?? "Bad request")"
        case .forbidden: return "Forbidden"
        case .notFound: return "Not found"
        case .selfNil: return "Self if nil"
        case .serverError: return "Server error"
        case .unauthorized: return "Unauthorized"
        case .unknown(let error): return "\(error.localizedDescription)"
        case .decodingError(let error): return "\(error.localizedDescription)"
        case .emptyData: return "The data is empty."
        case .requestAlreadyInProgress: return "Request Already In Progress"
        }
    }
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
