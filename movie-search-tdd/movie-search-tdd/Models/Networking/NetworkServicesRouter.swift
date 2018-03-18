//
//  NetworkServicesRouter.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/17/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import Alamofire

public enum NetworkServicesRouter: URLRequestConvertible {
    
    // MARK: - Properties
    static let baseURLPath = "http://api.themoviedb.org"
    static let imageBaseURLPath = "http://image.tmdb.org/t/p"
    static let apiKey = "ab7af61e73ec7d42ab86366c0e1374e9"
    
    enum posterSize: String {
        case small = "/w92"
        case medium = "/w185"
        case large = "/w500"
        case xLarge = "/w780"
    }
    
    // MARK: - Endpoint cases
    case searchMovies(String, Int)
    case otherService
    
    // MARK: - Endpoint cases
    var method: HTTPMethod {
        switch self {
        case .searchMovies:
            return .get
        case .otherService:
            return .post
        }
    }
    
    // MARK: - Endpoint Paths
    var path: String {
        switch self {
        case .searchMovies:
            return "/3/search/movie"
        case .otherService:
            return "/otherService"
        }
    }
    
    // MARK: - Public Methods
    
    /**
     Function that throws an URLRequest given a set case for an endpoint
     */
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .searchMovies(let term, let page):
                return ["query": term, "page": page, "api_key": NetworkServicesRouter.apiKey]
            default:
                return [:]
            }
        }()
        
        let url = try NetworkServicesRouter.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
