//
//  DeleteTopicRequest.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct DeleteTopicRequest: APIRequest {
    
    typealias Response = DeleteTopicResponse
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    
    var method: Method {
        return .DELETE
    }
    
    var path: String {
        return "t/-/\(id).json"
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

