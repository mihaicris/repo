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
    private let client = URLSessionHTTPClient()
    
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

    private func createListViewController() -> UIViewController { // TODO (Mihai): Add search bar with topic field
        
        guard let url = URL(string: Config.startURL) else {
            fatalError("Bad URL") // TODO (Mihai): HANDLE ERROR
        }
        
        let repositoryListLoader = RemoteRepositoryListLoader(url: url, client: self.client)
        let controller = ListViewController(repositoryLoader: repositoryListLoader)
        
        controller.onShowRepo = { [weak self] repository in
            guard let navController = controller.navigationController else {
                // TODO (Mihai): Handle Error
                return
            }
            self?.showFileContentViewController(repository, from: navController)
        }
        
        return controller
    }
    
    private func showDetailsViewController(_ repository: Repository, from navController: UINavigationController) {
        let controller = DetailsViewController(repository: repository)
        navController.pushViewController(controller, animated: true)
    }
    
    private func showFileContentViewController(_ repository: Repository, from navController: UINavigationController) {
        let fileContentLoader = RemoteFileContentLoader(url: repository.url, client: self.client)
        let controller = FileContentViewController(fileContentLoader: fileContentLoader)
        navController.pushViewController(controller, animated: true)
    }
    
}
