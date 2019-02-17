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
    
    // MARK: - Properties
    
    public static let identifier = "RepositoryCell"
    
    private let starColor = UIColor(red: 1, green: 0.5, blue: 0.0, alpha: 1)
    private let descriptionColor = UIColor.lightGray
    private let descriptionFont = UIFont.systemFont(ofSize: 12)
    private let fullNameFont = UIFont.systemFont(ofSize: 14)
    private let fullNameFontBold = UIFont.boldSystemFont(ofSize: 14)
    private let inset = 12
    
    private let repoFullNameLabel =  UILabel()
    private let repoDescriptionLabel = UILabel()
    private let repoStarsLabel = UILabel()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(style: .default, reuseIdentifier: RepositoryCell.identifier)
        setupViews()
    }

    // MARK: - Public
    
    func configure(model: RepositoryViewModel) {
        configureFullName(model.fullName)
        configureDescription(model.description)
        configureStars(model.numberOfStars)
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        setupStyle()
        setupLayout()
    }
    
    private func setupStyle() {
        repoDescriptionLabel.numberOfLines = 5
        repoDescriptionLabel.textColor = descriptionColor
        repoDescriptionLabel.font = descriptionFont
    }
    
    private func setupLayout() {
        self.contentView.addSubview(repoFullNameLabel)
        self.contentView.addSubview(repoDescriptionLabel)
        self.contentView.addSubview(repoStarsLabel)
        
        repoFullNameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(inset)
            make.right.lessThanOrEqualTo(repoStarsLabel.snp.left).inset(inset)
        }
        
        repoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(repoFullNameLabel.snp.bottom).offset(inset/3)
            make.left.right.equalToSuperview().inset(inset)
            make.bottom.equalToSuperview().inset(inset)
        }
        
        repoStarsLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(inset)
        }
    }
    
    private func configureFullName(_ text: String) {
        let components = text.split(separator: "/")
        guard components.count == 2 else {
            repoFullNameLabel.text = text
            return
        }
        
        let attributedString = NSMutableAttributedString(
            string: String("\(components[0])/"),
            attributes: [NSAttributedString.Key.font : fullNameFont]
        )
        
        attributedString.append(
            NSAttributedString(
                string: String(components[1]),
                attributes: [NSAttributedString.Key.font: fullNameFontBold])
        )
        
        repoFullNameLabel.attributedText = attributedString
    }
    
    private func configureDescription(_ text: String) {
        repoDescriptionLabel.text = text
    }
    
    private func configureStars(_ stars: Int) {
        let attributedString = NSMutableAttributedString(
            string: "\u{2605}",
            attributes: [NSAttributedString.Key.foregroundColor : starColor]
        )
        
        attributedString.append(
            NSAttributedString(
                string: " ",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 7)])
        )
    
        attributedString.append(
            NSAttributedString(string: "\(stars)",
            attributes: [NSAttributedString.Key.foregroundColor : descriptionColor,
                         NSAttributedString.Key.font: descriptionFont])
        )
        
        repoStarsLabel.attributedText = attributedString
    }
    

}
