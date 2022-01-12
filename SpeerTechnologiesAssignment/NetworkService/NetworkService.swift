//
//  NetworkService.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import UIKit

/// completion handler after parsing api
typealias CompletionHandler<T:Codable> = (Result<T, Error>)->()

/// Protocol for bridging gap between network service and NetworkCallHandler
protocol NetworkService {
    func sendGetRequest<T: Codable>(_ request: GithubAPI, completion: @escaping CompletionHandler<T>)
}

/// Default implementation for NetworkServices
class DefaultNetworkService : NetworkService {

    private let networkHandler: NetworkCallHandler

    init(_ networkHandler: NetworkCallHandler = URLSessionNetworkCallHandler()) {
        self.networkHandler = networkHandler
    }

    func sendGetRequest<T: Codable>(_ request: GithubAPI, completion: @escaping CompletionHandler<T>) {
        networkHandler.sendGetRequest(url: request.fullURL, params: [:]) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.nilData))
                return
            }
            guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(NetworkError.typeCastingError))
                return
            }

            completion(.success(decoded))
        }
    }
}

/// Basic Errors to be returned in case of some failures
enum NetworkError: Error {
    case invalidURL
    case nilData
    case typeCastingError
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .nilData:
            return "No Data Found"
        case .typeCastingError:
            return "Invalid Data Type Sent"
        }
    }
}
