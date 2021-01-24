//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 22/01/21.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController para representar el listado de usuarios
class UsersViewController: UIViewController {

    let viewModel: UsersViewModel
     
    lazy var tableView: UITableView = {
           let table = UITableView(frame: .zero, style: .grouped)
           table.translatesAutoresizingMaskIntoConstraints = false
           table.dataSource = self
           table.delegate = self
           table.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
           table.estimatedRowHeight = 100
           table.rowHeight = UITableView.automaticDimension
           return table
       }()
    
    
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        overrideUserInterfaceStyle = .light 
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    fileprivate func showErrorFetchingUsersAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching users\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension UsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            
            DispatchQueue.global(qos:.userInitiated).async {
                guard let avatarPath = cell.viewModel?.user.avatarTemplate else { return }
                let urlString = apiURL + (((avatarPath.replacingOccurrences(of: "{size}", with: "100"))))
                guard let data = try? Data(contentsOf: URL(string: urlString)!) else { return }
                let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                        cell.setNeedsLayout()
                    }
                }
            return cell
        }
        fatalError()
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController: UsersViewDelegate {
    func errorFetchingUsers() {
        showErrorFetchingUsersAlert()
    }
    
    func usersFetched() {
        tableView.reloadData()
    }
}


