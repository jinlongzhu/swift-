//
//  PageTitleView.swift
//  DouyuZB
//
//  Created by 朱金龙 on 2019/3/7.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit

//MARK:- 定义协议
protocol PageTitleViewDelegate : class {
    
    func pageTitle(titleView : PageTitleView, selectIndex index : Int)
}
//MARK:- 定义常量
private let kscrollLineH : CGFloat = 2

private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {

    // MARK: -定义属性
    private var titles : [String]
    private var labels : [UILabel]
    private var currentIndex : NSInteger
    weak var delegate : PageTitleViewDelegate?
    // MARK: -懒加载
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false;
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        
        return scrollLine
    }()
    
    
    // MARK: -自定义构造函数
    init(frame: CGRect , titles : [String]) {
        self.titles = titles
        self.labels = []
        self.currentIndex = 0
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加label
        setupTitleLabels()
        
        //添加底线滚动条
        setupBottomMenuAndScrollLine()
    }
    
    private func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kscrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated(){
            //创建
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            

            scrollView.addSubview(label)
            
            labels.append(label)
            
            //添加手势
            label.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(self.tapLabelGestureRecognizer(tap:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomMenuAndScrollLine(){
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let lineH :CGFloat = 0.5
        
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加滚动线
        scrollView.addSubview(scrollLine)
        
        //获取第一个label
        guard let firstLabel = labels.first else {
            return
        }
        firstLabel.textColor =  UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        currentIndex = firstLabel.tag
        scrollLine.backgroundColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kscrollLineH, width: firstLabel.frame.width, height: kscrollLineH)
        
        
    }
    
}
//MARK -注释内容
extension PageTitleView{
    
    @objc private func tapLabelGestureRecognizer(tap:UITapGestureRecognizer) {
       
        guard let currentLabel =  tap.view as? UILabel else {
            return
        }
        
        let oldLabel = labels[currentIndex]
        
        currentLabel.textColor =  UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX =
            CGFloat(currentLabel.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.1) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitle(titleView: self, selectIndex: currentIndex)
    }
}


// MARK: - 对外暴露方法

extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat , sourceIndex : Int , targetIndex : Int) {
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        //滚动条滚动
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色渐变
        //去除变化范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        //变化
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0*progress, g:  kSelectColor.1 - colorDelta.1*progress, b:  kSelectColor.2 - colorDelta.2*progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0*progress, g:  kNormalColor.1 + colorDelta.1*progress, b:  kNormalColor.2 + colorDelta.2*progress)
        
        currentIndex = targetIndex
    }
}
