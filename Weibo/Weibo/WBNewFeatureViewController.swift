//
//  WBWelcomeViewController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/30.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

class WBNewFeatureViewController: UICollectionViewController {

    private var layout = UICollectionViewFlowLayout()
    private let identifier_clv = "identifier_clv"
    private let count_page = 4
    
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        configureLayout()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.registerClass(WBNewFeatureViewCell.self, forCellWithReuseIdentifier: identifier_clv)
        
    }
    
    // MARK: - Configure
    
    private func configureLayout() {
        
        layout.itemSize = SCREEN_BOUNDS.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
        
    }
    
    // MARK: - UICollectionViewDelegate & UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count_page
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier_clv, forIndexPath: indexPath) as! WBNewFeatureViewCell
        
        cell.index = indexPath.item
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        
        if let path = collectionView.indexPathsForVisibleItems().last {
            if path.item == count_page - 1 {
                let cell = collectionView.cellForItemAtIndexPath(path) as! WBNewFeatureViewCell
                cell.configureButton()
            }
        }
        
    }
    
}
