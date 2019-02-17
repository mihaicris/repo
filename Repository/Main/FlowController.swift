//
//  FlowController.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import UIKit

final public class FlowController {
    
    private let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func createRootViewCotroller() -> UIViewController {
        let startViewController = ListViewController(style: .plain)
        
        startViewController.onShowRepo = { _ in }
        
        let navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}
