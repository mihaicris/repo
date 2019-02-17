//
//  RepositoryCell.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import UIKit
import SnapKit

final class RepositoryCell: UITableViewCell {
    
    private let identifier = "RepositoryCell"
    
    init() {
        super.init(style: .default, reuseIdentifier: identifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(style: .default, reuseIdentifier: identifier)
        setupViews()
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        
    }
}
