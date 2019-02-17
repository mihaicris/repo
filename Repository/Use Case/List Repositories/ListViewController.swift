//
//  ViewController.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var onShowRepo: ((Repository) -> Void)?
    
    var model: [Repository] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "iOS Repositories"
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        loadRepos()
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
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
    
    // MARK: - Helpers
    
    private func loadRepos() {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=topic:iOS+language:Swift&sort=stars&order=desc&per_page=100") else {
            fatalError("Bad URL")
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                fatalError("Error: Data task returned an error.")
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error: Bad URL Response")
            }
            
            guard let strongData = data else {
                fatalError("Error: Data is nil")
            }
            
            let jsonDeconder = JSONDecoder()
            jsonDeconder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let searchResult = try? jsonDeconder.decode(SearchResult.self, from: strongData) else {
                fatalError("Cannot convert data to object")
            }
            
            DispatchQueue.main.async {
                self.model = searchResult.items
            }
            
        }
        task.resume()
    }
}

