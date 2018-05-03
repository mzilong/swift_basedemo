//
//  MenuBar.swift
//  swift_basedemo
//
//  Created by Oscarma on 2018/4/28.
//  Copyright © 2018年 Oscarma. All rights reserved.
//

import UIKit

class MenuBar: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout);
        cv.backgroundColor = UIColor.rgb(red: 239, green: 32, blue: 31);
        cv.delegate = self;
        cv.dataSource = self;
        return cv;
    }();
    let cellId = "cellId";
    let icons = ["home", "trending", "subscriptions", "account"];
    var homeController: HomeController?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellId, for: indexPath) as! MenuBarCell;
        let image = UIImage(named:icons[indexPath.item])?.withRenderingMode(.alwaysTemplate);
        cell.imageView.image = image;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = frame.width/4;
        let h = frame.height;
        return CGSize(width: w, height: h);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId);
        backgroundColor = UIColor.rgb(red: 239, green: 32, blue: 31);
        addSubview(collectionView);
        addConstraintsWithVisual(format: "H:|[v0]|", views: collectionView);
        addConstraintsWithVisual(format: "V:|[v0]|", views: collectionView);
        
        let selectedIndexPath = IndexPath(item: 0, section: 0 );
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left);
        setupHorizontalBar();
    }
    
    var horizontalBarLeftAnchor: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchor = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        
        horizontalBarLeftAnchor?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuBarCell: BaseCell{
    let imageView:UIImageView = {
        let iv = UIImageView();
        iv.image = UIImage(named:"logo2.png");
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13);
        return iv;
    }();
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.white :UIColor.rgb(red: 91, green: 14, blue: 13);
        }
    }
    
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? UIColor.white :UIColor.rgb(red: 91, green: 14, blue: 13);
        }
    }
    
    override func setupViews() {
        addSubview(imageView);
        addConstraintsWithVisual(format: "H:[v0(30)]", views: imageView);
        addConstraintsWithVisual(format: "V:[v0(30)]", views: imageView);
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0));
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0));
    }
}
