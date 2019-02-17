//
//  ViewController.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    // MARK: - Properties
    
    private let repositoryLoader: RepositoryLoader
    
    public var onShowRepo: ((Repository) -> Void)?
    
    private var model: [Repository] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Initialization
    
    init(repositoryLoader: RepositoryLoader) {
        self.repositoryLoader = repositoryLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as? RepositoryCell else {
            return UITableViewCell()
        }
        let repository = self.model[indexPath.row]
        
        let model = RepositoryViewModel(fullName: repository.fullName,
                                        description: repository.description,
                                        numberOfStars: repository.stargazersCount)
        cell.configure(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = self.model[indexPath.row]
        self.onShowRepo?(repository)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "iOS Repositories"
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        loadRepos()
    }
    
    // MARK: - Helpers
    
    private func loadRepos() {
        repositoryLoader.load { result in
            switch result {
            case let .success(repositories):
                self.model = repositories
            case let .failure(error):
                print(error) // TODO: Handle Error
            }
        }
    }
}

