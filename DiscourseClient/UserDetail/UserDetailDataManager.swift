//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// DataManager con las operaciones necesarias de este módulo
protocol UserDetailDataManager: class {
    func fetchUser(user: User, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
    func changeUserName(user:User, completion: @escaping (Result<ChangeUserNameResponse?, Error>) -> ())
}
