//
//  UserCoordinator.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator que representa el tab del users list
class UsersCoordinator: Coordinator, UserDetailCoordinatorDelegate, UsersCoordinatorDelegate {
    
    func userDetailEditButtonTapped(newName: String) {
        userSelected?.name = newName

  
        userDetailDataManager.changeUserName(user: userSelected!) { [weak self] (result) in
            switch result {
            case .success(let response):
                print(response ?? "Sin cambios en el sistema")
                if let userChanging = self?.usersViewModel?.userViewModels.first(where: {$0.user.id == self?.userSelected?.id}){
                    userChanging.textLabelText = newName
                    userChanging.user.name = newName
                    let title = NSLocalizedString("Updated Ok" , comment:"")
                    if let responseUnwrapped = response {
                        let message = NSLocalizedString("The response was: \(responseUnwrapped.success)" , comment:"")
                        self?.showAlert(message, title)
                    }
                    self?.usersViewModel?.userNameChanged()
                }
                break
            case .failure(let error):
                print("Fallo al cambiar el nombre de usuario: \(error)")
            }
        }
    }
    
    func showAlert(_ alertMessage: String,
                               _ alertTitle: String = NSLocalizedString("Error", comment: ""),
                               _ alertActionTitle: String = NSLocalizedString("OK", comment: "")) {

        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: {(alert: UIAlertAction) in self.userDetailBackButtonTapped()}))
        presenter.present(alertController, animated: true, completion: nil)
    }
    
    func userDetailBackButtonTapped() {
        presenter.popViewController(animated: true)
    }
    
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDetailDataManager: UserDetailDataManager
    var usersViewModel: UsersViewModel?
    var userSelected: User?

    init(presenter: UINavigationController, usersDataManager: UsersDataManager, userDetailDataManager: UserDetailDataManager) {
        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }

    func didSelect(user: User) {

        let userDetailViewModel = UserDetailViewModel(userID: user.id, canEditName: true, userDetailDataManager: userDetailDataManager)
        let userDetailViewController = UserDetailViewController(viewModel: userDetailViewModel, avatarPath: "")
        userSelected = user
        userDetailViewController.title = NSLocalizedString("\(user.username)", comment: "")
        print("SELECCIONAMOS EL USER \(user.username)")
        userDetailViewController.labelUserID.text = "\(user.id)"
        userDetailViewController.labelUserName.text = "\(user.name ?? "")"
        userDetailViewController.textUserName.text = "\(user.name ?? "")"
        userDetailViewController.avatarPath = user.avatarTemplate
        userDetailDataManager.fetchUser(user: user) { (result) in
            switch result {
            case .success(let response):
                print(response ?? "NO HAY RESPUESTA")
                if ((response?.user.canEditName) != nil && response?.user.canEditName == true) {
                    userDetailViewController.userNameStackView.isHidden = true
                    userDetailViewController.userNameEditStackView.isHidden = false
                    userDetailViewController.userNameButtonStackView.isHidden = false
                    print("PODEMOS CAMBIAR EL NOMBRE")
                } else {
                    userDetailViewController.userNameStackView.isHidden = false
                    userDetailViewController.userNameEditStackView.isHidden = true
                    userDetailViewController.userNameButtonStackView.isHidden = true
                    print("NO PODEMOS CAMBIAR EL NOMBRE")
                }
                break
            case .failure(let error):
                print(error)
                    }
            }
        userDetailViewModel.viewDelegate = userDetailViewController
        userDetailViewModel.coordinatorDelegate = self
        presenter.pushViewController(userDetailViewController, animated: true)
    }
        
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        self.usersViewModel = usersViewModel
        presenter.pushViewController(usersViewController, animated: false)
    }
    
    override func finish() {}
}
