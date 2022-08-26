//
//  BackendAPI.swift
//  TestProject
//
//  Created by Dmitriy Eni on 25.08.2022.
//

import Foundation
import Moya

enum BackendAPI {
    case getUsers(page: Int)
    case uploadPhoto
}

extension BackendAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://junior.balinasoft.com")!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/api/v2/photo/type"
        case .uploadPhoto:
            return "/api/v2/photo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        case .uploadPhoto:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        guard let params = params else {
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var params: [String: Any]? {
        var params = [String: Any]()
        switch self {
        case .getUsers(let page):
            params["page"] = page
        case .uploadPhoto:
            return nil
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self  {
        case .getUsers:
            return URLEncoding.queryString
        default:
            return JSONEncoding.prettyPrinted
        }
    }
}
