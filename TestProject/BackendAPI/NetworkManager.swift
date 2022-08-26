//
//  NetworkManager.swift
//  TestProject
//
//  Created by Dmitriy Eni on 25.08.2022.
//

import Foundation
import Moya
import Moya_ObjectMapper

var isPagination = false
var totalPage = 0

class NetworkManager {
    static let provider = MoyaProvider<BackendAPI>(plugins: [NetworkLoggerPlugin()])
    class func getUsers(pagination: Bool = false, page: Int, successBlock: (([Profile]) -> ())?, failureBlock: (() -> ())?) {
        if pagination {
            isPagination = true
        }
        provider.request(.getUsers(page: page)) { result in
            switch result {
            case .success(let response):
                isPagination = true
                guard let profiles = try? response.mapObject(Content.self) else {
                    failureBlock?()
                    return
                }
                isPagination = false
                totalPage = profiles.totalPages
                successBlock?(profiles.content)
            case .failure(_):
                failureBlock?()
            }
        }
    }
}
