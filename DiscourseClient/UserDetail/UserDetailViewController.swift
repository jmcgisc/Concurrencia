//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
  
    var avatarPath: String
    
    lazy var labelUserID: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelUserName: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textUserName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var buttonUserName: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("User ID: ", comment: "")
        labelUserIDTitle.textColor = .orange
        labelUserIDTitle.backgroundColor = .gray

        let userIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, labelUserID])
        userIDStackView.translatesAutoresizingMaskIntoConstraints = false
        userIDStackView.axis = .horizontal

        return userIDStackView
    }()

    lazy var userNameStackView: UIStackView = {
        let labelUserNameTitle = UILabel()
        labelUserNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserNameTitle.text = NSLocalizedString("User Name: ", comment: "")
        labelUserNameTitle.textColor = .red
        labelUserNameTitle.backgroundColor = .gray

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserNameTitle, labelUserName])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .horizontal

        return userNameStackView
    }()
    
    lazy var userNameEditStackView: UIStackView = {
        let labelUserEditNameTitle = UITextField()
        labelUserEditNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserEditNameTitle.text = NSLocalizedString("User Name: ", comment: "")
        labelUserEditNameTitle.textColor = .green
        labelUserEditNameTitle.backgroundColor = .gray

        let userNameEditStackView = UIStackView(arrangedSubviews: [labelUserEditNameTitle, textUserName])
        userNameEditStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameEditStackView.axis = .horizontal

        return userNameEditStackView
    }()
    
    lazy var userNameButtonStackView: UIStackView = {
        let userNameButton = UIButton()
        userNameButton.translatesAutoresizingMaskIntoConstraints = false
        userNameButton.setTitle(NSLocalizedString("Update Name", comment: ""), for: .normal)
        userNameButton.setTitleColor(.green, for: .normal)
        userNameButton.backgroundColor = .darkGray
        userNameButton.addTarget(self, action: #selector(updateButtonTapped(sender:)), for: .touchUpInside)

        let userNameButtonStackView = UIStackView(arrangedSubviews: [userNameButton, buttonUserName])
        userNameButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameButtonStackView.axis = .horizontal
        userNameButtonStackView.distribution = .fillEqually
        userNameButtonStackView.alignment = .fill
        userNameButtonStackView.spacing   = 5

        return userNameButtonStackView
    }()
    
    let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel, avatarPath: String) {
        self.viewModel = viewModel
        self.avatarPath = avatarPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view  = UIView()
        
        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        
        view.addSubview(userNameStackView)
        NSLayoutConstraint.activate([
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameStackView.topAnchor.constraint(equalTo: userIDStackView.topAnchor, constant: 16),
        ])
        
        view.addSubview(userNameEditStackView)
        NSLayoutConstraint.activate([
            userNameEditStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameEditStackView.topAnchor.constraint(equalTo: userIDStackView.topAnchor, constant: 16)
        ])
        
        view.addSubview(userNameButtonStackView)
        NSLayoutConstraint.activate([
            userNameButtonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameButtonStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            userNameButtonStackView.topAnchor.constraint(equalTo: userNameEditStackView.topAnchor, constant: 64)
        ])
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .green
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
       }
    
    @objc func updateButtonTapped(sender: UIButton!) {
        print("Se updatea nombre \(textUserName.text ?? "Usuario")")
        viewModel.editButtonTapped(newName: textUserName.text ?? "")
       }
    
    fileprivate func showErrorFetchingUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching user detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI() {
        labelUserName.text = viewModel.labelUserNameText
    }

    
}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailFetched() {
        if viewModel.canEditName {
            
        } else {
            
        }
        self.updateUI()
    }

    func errorFetchingUserDetail() {
        showErrorFetchingUserDetailAlert()
    }
}
