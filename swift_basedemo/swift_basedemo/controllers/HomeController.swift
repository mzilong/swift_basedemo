//
//  ViewController.swift
//  swift_basedemo
//
//  Created by Oscarma on 2018/4/27.
//  Copyright © 2018年 Oscarma. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{
    let cellId = "cellId";
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = UIColor.gray;
        //向下移动50距离
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0);
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId);
        setupNavigation();
        setupMenuBar();
        
        setupCollectionView();
    }
    
    private func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isPagingEnabled = true;
    }
    
    func setupNavigation(){
//        navigationController!.navigationBar.barTintColor = UIColor.rgb(red: 239, green: 32, blue: 31);
        navigationController!.navigationBar.isTranslucent = false;
        navigationController!.navigationBar.tintColor = UIColor.white;
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 30, height: view.frame.height));
        titleLable.text = "HOME";
        titleLable.textColor = UIColor.white;
        titleLable.font = UIFont.systemFont(ofSize: 20);
        navigationItem.titleView  = titleLable;
        let btnRightSearch =  UIBarButtonItem(barButtonSystemItem:.search, target: self, action:#selector(handleSearch));
        let btnRightMore =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(handleAdd));
        navigationItem.rightBarButtonItems = [btnRightMore,btnRightSearch];
    }
    
    lazy var menuBar:MenuBar = {
        let menuBar = MenuBar();
        menuBar.homeController = self;
        return menuBar;
    }();
    
    func setupMenuBar(){
//        navigationController?.hidesBarsOnSwipe = true;
//        let redView = UIView()
//        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
//        view.addSubview(redView)
//        view.addConstraintsWithVisual(format: "H:|[v0]|", views: redView);
//        view.addConstraintsWithVisual(format: "V:[v0(50)]", views: redView);
        
        view.addSubview(menuBar);
        view.addConstraintsWithVisual(format:"H:|[v0]|",views: menuBar);
        view.addConstraintsWithVisual(format:"V:|[v0(50)]|",views: menuBar);
        
//        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell;
        cell.curIndexPath = indexPath;
        return cell;
    }
    let settingsLauncher = SettingsLauncher();
    @objc func handleAdd(){
        settingsLauncher.homeController = self;
        settingsLauncher.showSettings();
    }
    @objc func handleSearch(){
        scrollToMenuIndex(menuIndex: 2);
        menuBar.collectionView.selectItem(at: IndexPath(item: 2, section: 0), animated: true, scrollPosition: .left);
    }
    
    func showControllerForSettings(setting: Setting) {
        let dummySettingViewController = UIViewController()
        dummySettingViewController.navigationItem.title = setting.name
        navigationController?.navigationBar.tintColor = UIColor.white
        dummySettingViewController.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at:.left, animated: true);
        setTitleForIndex(index: indexPath.item);
        collectionView?.reloadData();
        
    }
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "\(titles[index])"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = view.frame.width;
        let rect = UIApplication.shared.statusBarFrame;
        let rect2 = navigationController?.navigationBar.frame;
        let h = view.frame.height - rect.size.height - (rect2?.size.height)!;
        return CGSize(width: w, height: h);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchor?.constant = scrollView.contentOffset.x/4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let _index = Int(targetContentOffset.pointee.x / view.frame.width);
        menuBar.collectionView.selectItem(at: IndexPath(item: _index, section: 0), animated: true, scrollPosition: .left);
        
        setTitleForIndex(index: _index);
    }
}

