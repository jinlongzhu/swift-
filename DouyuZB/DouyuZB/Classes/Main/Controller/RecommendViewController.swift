//
//  RecommendViewController.swift
//  DouyuZB
//
//  Created by dingjunchuxing on 2019/3/13.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10.0
private let kItemW : CGFloat = (kScreenW - 3*kItemMargin) / 2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kPrettyH : CGFloat = kItemW * 4 / 3
private let kheaderH : CGFloat = 50


private let kNormalCellID = "kNormalCellID"
private let kPrettyID = "kPrettyID"
private let kHeaderID = "kHeaderID"

class RecommendViewController: UIViewController {
    private lazy var recommendVM : RemmendViewModel = RemmendViewModel()
    
    private lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kheaderH)
        
        let collectinonView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
        collectinonView.dataSource = self
        collectinonView.delegate = self
        collectinonView.register(UINib(nibName:"CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectinonView.register(UINib(nibName:"CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyID)
        collectinonView.register(UINib(nibName: "CollectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderID)
        collectinonView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collectinonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
        
    }
    
    // MARK: - Navigation

}

 // MARK: - 设置UI界面

extension RecommendViewController {
    
    func setupUI(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
    
        
    }
    
}

extension RecommendViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorGroups[section].anchors.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
       
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderID, for: indexPath) as! CollectionHeaderReusableView
        
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
   {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyH)
        }else{
             return CGSize(width: kItemW, height: kItemH)
        }
    }
    
}


extension RecommendViewController{
    
    func loadData() {
         recommendVM.requstData {
            self.collectionView.reloadData()
        }
    }
}
