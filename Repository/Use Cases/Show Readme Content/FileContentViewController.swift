//
//  ReadMeViewController.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import UIKit
import Down
import SnapKit

class FileContentViewController: UIViewController {
    
    // MARK: - Properties
    
    private let fileContentLoader: FileContentLoader
    
    // MARK: - Initialization
    
    init(fileContentLoader: FileContentLoader) {
        self.fileContentLoader = fileContentLoader
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "README.md"
        loadContent()
    }
    
    // MARK: - Helpers
    
    private func loadContent() {
        fileContentLoader.load { [weak self] result in
            switch result {
            case let .success(file):
                guard let markdown = file.contentString else { return }
                self?.updateView(with: markdown)
            case let .failure(error):
                // TODO (Mihai): Handle Error
                print(error)
            }
        }
    }
    
    private func updateView(with markdown: String) {
        guard let downView = try? DownView(frame: CGRect.zero, markdownString: markdown) else { return }
        self.view.addSubview(downView)
        downView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}
