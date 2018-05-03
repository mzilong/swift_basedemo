//
//  SettingCell.swift
//  swift_basedemo
//
//  Created by Oscarma on 2018/5/2.
//  Copyright © 2018年 Oscarma. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Setting"
        lb.font = UIFont.systemFont(ofSize: 13)
        return lb
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func setupViews() {
        // Do something
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithVisual(format: "H:|-16-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstraintsWithVisual(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithVisual(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        backgroundColor = UIColor.white
    }
    
}

