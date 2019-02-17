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
    
    private let fileContentLoader: FileContentLoader
    
    init(fileContentLoader: FileContentLoader) {
        self.fileContentLoader = fileContentLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://api.github.com/repos/peripheryapp/periphery/readme") else {
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
            
            guard let file = try? jsonDeconder.decode(File.self, from: strongData) else {
                fatalError("Cannot convert data to object")
            }
            
            guard let markdown = file.contentString else { return }
            
            
            DispatchQueue.main.async {
                self.updateView(with: markdown)
            }
            
        }
        task.resume()
    }
    
    private func updateView(with markdown: String) {
        guard let downView = try? DownView(frame: CGRect.zero, markdownString: markdown) else { return }
        self.view.addSubview(downView)
        downView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
