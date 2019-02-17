//
//  FlowController.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import UIKit

final public class FlowController {
    
    // MARK: - Properties
    
    private let window: UIWindow
    
    // MARK: - Initialization
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func createRootViewCotroller() -> UIViewController {
        let controller = createListViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
    
    // MARK: - Helpers

    private func createListViewController() -> UIViewController {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=topic:iOS+language:Swift&sort=stars&order=desc&per_page=100") else {
            fatalError("Bad URL")
        }
        
        let client = URLSessionHTTPClient()
        let repositoryLoader = RemoteRepositoryLoader(url: url, client: client)
        let controller = ListViewController(repositoryLoader: repositoryLoader)
        
        controller.onShowRepo = { [weak self] repository in
            guard let navController = controller.navigationController else {
                print("Handle Error")
                return
            }
            controller.title = "Back"
            self?.showDetailsViewController(repository, from: navController)
        }
        
        return controller
    }
    
    private func showDetailsViewController(_ repository: Repository, from navController: UINavigationController) {
        let controller = DetailsViewController(repository: repository)
        navController.pushViewController(controller, animated: true)
    }
    

}
