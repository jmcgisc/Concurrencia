//
//  UsersDataManager.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Errores que pueden darse en el topics data manager
enum UsersDataManagerError: Error {
    case unknown
}

protocol UsersDataManager {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
}
