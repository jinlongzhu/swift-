//
//  HomeViewController.swift
//  DouyuZB
//
//  Created by 朱金龙 on 2019/3/6.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class HomeViewController: UIViewController {
    // MARK: - 懒加载
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        //1.确定frame
        let contentH = kScreenH - kStatusBarH-kNavigationH
        let contentFrame  = CGRect(x: 0, y: kStatusBarH+kNavigationH+kTitleViewH, width: kScreenW, height: contentH)
        //2.vc
        var childs = [UIViewController]()
        
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childs, parentViewController: self!)
        contentView.delegate = self
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //设置UI
        setupUI();
        
        
    }
}

extension HomeViewController {
    private func setupUI() {
        
        //1.设置导航栏
        setupNavigationBar();
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar (){
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //右侧
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "Image_my_history_click", hightImageName: "image_my_history", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search_clicked", hightImageName: "btn_search", size: size);
        let grCodeItem = UIBarButtonItem(imageName: "Image_scan_click", hightImageName: "Image_scan", size: size)
        
        
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,grCodeItem]
        
    }
}

extension HomeViewController : PageTitleViewDelegate{
    func pageTitle(titleView: PageTitleView, selectIndex index: Int) {
       pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
  
}
