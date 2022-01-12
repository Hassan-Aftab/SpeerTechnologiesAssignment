//
//  NetworkCallHandler.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation

typealias NetworkCallCompletionHandler = (Data?, URLResponse?, Error?)->()

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

protocol NetworkCallHandler {
    func sendGetRequest(url: String, params: [String: String], completionHandler: @escaping NetworkCallCompletionHandler)
}

class URLSessionNetworkCallHandler: NetworkCallHandler {
    func sendGetRequest(url: String, params: [String: String], completionHandler: @escaping NetworkCallCompletionHandler) {

        var url = url + "?"

        for (key, val) in params {
            url += key + "=" + val + "&"
        }

        guard let url = URL(string: url) else {
            completionHandler(nil, nil, NetworkError.invalidURL)
            return
        }
        var request = URLRequest(url: url)

        request.httpMethod = HTTPMethod.GET.rawValue

        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
