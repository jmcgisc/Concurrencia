//
//  UserResponse.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 25/19/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct UsersResponse: Codable {
    let directoryItems: [DirectoryItem]
      enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
      }
    }


struct DirectoryItem: Codable {
    let user: User
}

class User: Codable {
    let id: Int
    let username: String
    var name: String?
    let avatarTemplate: String
    let canEditName: Bool?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case name = "name"
        case avatarTemplate = "avatar_template"
        case canEditName = "can_edit_name"
    }
}
