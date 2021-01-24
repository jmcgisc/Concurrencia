//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol UserDetailCoordinatorDelegate: class {
    func userDetailBackButtonTapped()
    func userDetailEditButtonTapped(newName: String)
}
/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol UserDetailViewDelegate: class {
    func userDetailFetched()
}

class UserDetailViewModel {
    var labelUserNameText:String?
    var labelNameText: String?

    
    
    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    let userID: Int
    let canEditName: Bool
    
    init(userID: Int, canEditName: Bool, userDetailDataManager: UserDetailDataManager) {
        self.userID = userID
        self.canEditName = canEditName
        self.userDetailDataManager = userDetailDataManager
    }
    
    func viewDidLoad() {
        
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped()
    }
    
    func editButtonTapped(newName: String) {
        coordinatorDelegate?.userDetailEditButtonTapped(newName: newName)
    }

}
