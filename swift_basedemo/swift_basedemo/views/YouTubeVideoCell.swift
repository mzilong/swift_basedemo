//
//  YouTubeVideoCell.swift
//  swift_basedemo
//
//  Created by Oscarma on 2018/5/2.
//  Copyright © 2018年 Oscarma. All rights reserved.
//

import UIKit

class BaseCell :UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupViews();
    }
    func setupViews(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YouTubeVideoCell :BaseCell{
    
    var curIndexPath:IndexPath? {
        didSet{
            titleLabel.text = "我是标题\(String(describing: curIndexPath?.row))";
            browseLabel.text = "我是浏览量\(String(describing: curIndexPath?.row))";
        }
    };
    
    let videoThumbnailView:UIImageView = {
        let imageView = UIImageView();
        //            imageView.image = UIImage(named: "logo2.png");
        imageView.backgroundColor = UIColor.black;
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        return imageView;
    }();
    
    let headPortraitView:UIImageView = {
        let imageView = UIImageView();
        //            imageView.image = UIImage(named: "logo2.png");
        imageView.backgroundColor = UIColor.black;
        imageView.layer.cornerRadius = 25;
        imageView.layer.masksToBounds = true;
        return imageView;
    }();
    
    let titleLabel:UILabel = {
        let label = UILabel();
        label.text = "我是标题";
        return label;
    }();
    
    let browseLabel:UILabel = {
        let label = UILabel();
        label.text = "我是浏览量";
        label.textColor = UIColor.darkGray;
        return label;
    }();
    
    override func setupViews(){
        backgroundColor = UIColor.white;
        addSubview(videoThumbnailView);
        addSubview(headPortraitView);
        addSubview(titleLabel);
        addSubview(browseLabel);
        addConstraintsWithVisual(format:"H:|-10-[v0]-10-|",views: videoThumbnailView);
        addConstraintsWithVisual(format:"V:|-10-[v0]-10-[v1(50)]-10-|",views: videoThumbnailView,headPortraitView);
        addConstraintsWithVisual(format:"H:|-10-[v0(50)]-10-[v1]-10-|",views: headPortraitView,titleLabel);
        addConstraintsWithVisual(format:"H:|-10-[v0(50)]-10-[v1]-10-|",views: headPortraitView,browseLabel);
        addConstraintsWithVisual(format:"V:|-10-[v0]-10-[v1]-10-[v2]-10-|",views: videoThumbnailView,titleLabel,browseLabel);
    }
}

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var curIndexPath:IndexPath?
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout:layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(collectionView)
        addConstraintsWithVisual(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithVisual(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(YouTubeVideoCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! YouTubeVideoCell
        cell.curIndexPath = curIndexPath;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = frame.width;
        let h = frame.width * 9/16+80;
        return CGSize(width: w, height: h);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}
