//
//  Router.swift
//  PlatedChallenge
//
//  Created by Bryan Dubay on 5/22/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case menus
    case recipes(menuID: Int)
    
    // MARK: - HTTPMethod
    internal var method: HTTPMethod {
        switch self {
        case .menus:
            return .get
        case .recipes:
            return .get
        }
    }
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .menus:
            return "/menus.json"
        case .recipes(let menuID):
            return "/menus/\(menuID)/recipes.json"
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        switch self {
        case .menus:
            return nil
        case .recipes:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        print(urlRequest.url)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        urlRequest.setValue(NetworkConstants.authHeader, forHTTPHeaderField: "Authorization")
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
