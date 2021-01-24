//
//  UsersRequest.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación de la request que obtiene los usuarios

struct UsersRequest: APIRequest {
    
    typealias Response = UsersResponse
    
    let period: String
     let order: String
     
     init(period: String,
          order: String) {
         self.period = period
         self.order = order
     }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/directory_items.json"
    }
    
    var parameters: [String : String] {
        let jsonParameters: [String: String] = [
          "period": period,
          "order": order
        ]
        return jsonParameters
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
