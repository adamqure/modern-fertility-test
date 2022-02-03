//
//  RemoteNetworkProvider.swift
//  Modern Fertility Assessment
//
//  Created by Adam Ure on 2/2/22.
//

import Foundation

// MARK: - HTTPRequest

/// HTTP Request type enumeration based on a REST APIs
enum HTTPRequest: String {
    /// - Get: Designates an HTTP GET request
    case get = "GET"
}

// MARK: - RemoteNetworkProvider Protocol

/// A provider for network services
protocol RemoteNetworkProvider {
    /// This method performs an HTTP URL request to the url provided
    ///
    ///  ```
    ///  performRequest("https://www.apple.com")
    ///  ```
    ///
    /// - Parameter url: The url to which the HTTP request should be made
    /// - Parameter type: The HTTP request type to be run
    /// - Parameter body: Any request body to be included in the request. Can be nil
    /// - Returns: A result object including the data retrieved from the network request. If an error occurs at some point during the request, the result will surface an Error to be handled by the client.
    func performRequest(at url: String, _ type: HTTPRequest, _ body: AnyObject?) async -> Result<Data?, Error>
}

// MARK: - DefaultRemoteNetworkProvider Implementation

class DefaultRemoteNetworkProvider: RemoteNetworkProvider {
    func performRequest(at url: String, _ type: HTTPRequest = .get, _ body: AnyObject? = nil) async -> Result<Data?, Error> {
        // Create URL Request
        guard let url = URL(string: url) else {
            return .failure(NetworkError.invalidURL)
        }
        
        // TODO: Handle HTTP Body
            
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}

// MARK: - Network Error

/// Errors to be thrown from a network request
enum NetworkError: Error, CustomStringConvertible {
    case invalidURL

    public var description: String {
        switch self {
            case .invalidURL: return NSLocalizedString("invalid_url", comment: "Invalid URL")
        }
    }
}
