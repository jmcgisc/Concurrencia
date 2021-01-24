//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
import UIKit

/// ViewModel que representa un usuario en la lista
class UserCellViewModel {
    var user: User
    var textLabelText: String?
    
    init(user: User) {
        self.user = user
        self.textLabelText = user.name
    }
}
