//
//  ViewController.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var onShowRepo: ((URL) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "iOS Repositories"
        
        self.loadRepos()
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
            
            print(searchResult.items.count)
            
        }
        task.resume()
    }
}

