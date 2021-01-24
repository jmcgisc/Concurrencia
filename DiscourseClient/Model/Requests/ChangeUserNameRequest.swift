//
//  ChangeUserNameRequest.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

// DONE: Implementar las propiedades de esta request
struct ChangeUserNameRequest: APIRequest {
    
    
    typealias Response = ChangeUserNameResponse
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/users/\(user.username).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        guard let name = user.name else { return ["name": ""]}
        let bodyJSON: [String: Any] = ["name": name]
        return bodyJSON
    }
    
    var headers: [String : String] {
        return [:]
    }
}
