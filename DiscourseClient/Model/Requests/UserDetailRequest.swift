//
//  UserDetailRequest.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

// TODO: Implementar las propiedades de esta request
struct UserDetailRequest: APIRequest {
    
    typealias Response = UserDetailResponse
    
    let username: String
    
    init(username: String) {
        self.username = username
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/users/\(username).json"
        
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
