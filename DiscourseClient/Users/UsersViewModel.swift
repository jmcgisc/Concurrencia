//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}
 
protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

/// ViewModel representando un listado de usuarios
class UsersViewModel {
     
    let usersDataManager: UsersDataManager
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    var userViewModels: [UserCellViewModel] = []
    
    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded() {
        
        self.fetchUserList()
    }
    
    func fetchUserList() {
        usersDataManager.fetchAllUsers{ result in
            switch result {
            case .success(let response):
                if let itemsArray = response?.directoryItems {
                    for item in itemsArray {
                        self.userViewModels.append(UserCellViewModel(user: item.user))
                    }
                }
                self.viewDelegate?.usersFetched()
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: userViewModels[indexPath.row].user)
    }
    
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }
    
    func userNameChanged(){
        self.viewDelegate?.usersFetched()
    }
    
    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        return userViewModels[indexPath.row]
    }
}
