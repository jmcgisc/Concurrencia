//
//  LatestTopicsRequest.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

/// Implementación de la request que obtiene los latest topics
struct LatestTopicsRequest: APIRequest {
    
    typealias Response = LatestTopicsResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/latest.json"
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
