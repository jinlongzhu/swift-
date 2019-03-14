//
//  PageContentView.swift
//  DouyuZB
//
//  Created by 朱金龙 on 2019/3/10.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    
    func pageContentView(contentView : PageContentView , progress : CGFloat , sourceIndex : Int , targetIndex : Int)
}

private let contentCellId = "UICollectionViewCell"
class PageContentView: UIView {

    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffset : CGFloat
    private var isForbidDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    // 懒加载属性
    private lazy var collectionView : UICollectionView =  { [weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        return collectionView
        
    }()
    
    
     init(frame: CGRect,childVcs: [UIViewController],parentViewController : UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        self.startOffset = 0.0
        super.init(frame:frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    
    private func setupUI(){
        //1.添加VC
        for child in childVcs{
            parentViewController?.addChild(child)
        }
        
        //2.添加collecttion
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let vc = childVcs[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        return cell
    }
}
extension PageContentView : UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidDelegate {
            return
        }
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffset {
            //左滑
            progress = currentOffsetX.truncatingRemainder(dividingBy: scrollViewW)/scrollViewW
            sourceIndex = Int(currentOffsetX/scrollViewW)
            
            targetIndex = sourceIndex + 1
            if(targetIndex >= childVcs.count){
                targetIndex = childVcs.count - 1
            }
            
            if currentOffsetX - startOffset == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{
            //右划
            progress = 1 - currentOffsetX.truncatingRemainder(dividingBy: scrollViewW)/scrollViewW
           
            targetIndex = Int(currentOffsetX/scrollViewW)
            
            sourceIndex = targetIndex + 1
            
            if(sourceIndex >= childVcs.count){
                sourceIndex = childVcs.count - 1
            }
        }
        
        //3.传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex:targetIndex)
        
        
        
    }
}
// MARK: - 对外暴露方法

extension PageContentView {
    
    func setCurrentIndex(currentIndex : Int) {
        
        isForbidDelegate = true
        
        let offfsetX = CGFloat(currentIndex)*collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offfsetX, y: 0), animated: false)
    }
}


