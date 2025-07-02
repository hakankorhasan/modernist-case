//
//  NetworkService.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

//
//  NetworkService.swift
//  modernist-case
//
//  Created by Hakan on 30.06.2025.
//

import Foundation
import Combine

final class NetworkService: APIClient {
    static let shared = NetworkService()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T: Decodable>(_ endpoint: UserAPI, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        let request = endpoint.urlRequest

        return session.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, response in
                guard let self = self else {
                    throw NetworkError.selfNil
                }

                try Self.prettyPrint(request: request, response: data, statusCode: (response as? HTTPURLResponse)?.statusCode)
                try Self.validateStatusCode(response: response, data: data)
                return try self.decoder.decode(T.self, from: data)
            }
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                } else if let netError = error as? NetworkError {
                    return netError
                } else if let urlError = error as? URLError {
                    return .urlError(urlError)
                } else {
                    return .unknown(error)
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Status Code Validation

    private static func validateStatusCode(response: URLResponse, data: Data?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidData
        }

        switch httpResponse.statusCode {
        case 200..<300:
            return
        case 400:
            let internalError = parseInternalError(from: data)
            throw NetworkError.badRequest(internalError)
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.serverError
        default:
            let error = NSError(domain: "", code: httpResponse.statusCode)
            throw NetworkError.unknown(error)
        }
    }

    // MARK: - Internal Error Parser

    private static func parseInternalError(from data: Data?) -> InternalError {
        guard let data = data else { return InternalError(message: nil, param: nil) }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let message = json?["message"] as? String
            let param = json?["param"] as? String
            return InternalError(message: message, param: param)
        } catch {
            return InternalError(message: nil, param: nil)
        }
    }

    // MARK: - Debug Logging

    private static func prettyPrint(request: URLRequest, response: Data?, statusCode: Int?) throws {
        print("\n🔵 REQUEST")
        print("➡️ \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        print("📡 Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody {
            print("📦 Body: \(String(data: body, encoding: .utf8) ?? "")")
        }

        if let code = statusCode {
            print("\n🟢 RESPONSE [\(code)]")
        }
        if let response = response {
            if let json = try? JSONSerialization.jsonObject(with: response, options: []),
               let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
               let pretty = String(data: data, encoding: .utf8) {
                print("📥 Body:\n\(pretty)")
            } else {
                print("📥 Raw:\n\(String(data: response, encoding: .utf8) ?? "N/A")")
            }
        }
        print("⛔️ END\n")
    }
}

