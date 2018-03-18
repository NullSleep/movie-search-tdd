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
    static let apiKey = "ab7af61e73ec7d42ab86366c0e1374e9"
    
    // MARK: - Endpoint cases
    case serachMovies(String, Int)
    case otherService
    
    // MARK: - Endpoint cases
    var method: HTTPMethod {
        switch self {
        case .serachMovies:
            return .get
        case .otherService:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .serachMovies:
            return "/3/search/movie"
        case .otherService:
            return "/otherService"
        }
    }
    
    /**
     Function that throws an URLRequest given a set case for an endpoint
     */
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .serachMovies(let term, let page):
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
