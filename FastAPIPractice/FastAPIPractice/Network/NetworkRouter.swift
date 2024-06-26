//
//  NetworkRouter.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/25/24.
//

import Foundation
import Alamofire

enum NetworkRouter: URLRequestConvertible {
    case checkId(id: String)
    case registerUser(username: String, id: String, password: String)
    case login(id: String, password: String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .checkId(let id):
            return "/register/\(id)"
        case .registerUser:
            return "/register/register_user"
        case .login:
            return "/auth/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .checkId:
            return .get
        case .registerUser:
            return .post
        case .login:
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .checkId:
            return nil
            
        case let .registerUser(username, id, password):
            var params = Parameters()
            params["username"] = username
            params["id"] = id
            params["password"] = password
            return params
            
        case let .login(id, password):
            var params = Parameters()
            params["id"] = id
            params["password"] = password
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        request.method = method
//        if let parameters = parameters {
//            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
//        }
        
        if let parameters = parameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        return request
    }
}
