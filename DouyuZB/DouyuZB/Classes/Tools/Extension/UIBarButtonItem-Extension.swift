//
//  UIBarButtonItem-Extension.swift
//  DouyuZB
//
//  Created by 朱金龙 on 2019/3/7.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    //类别的写法
    class func createItem(imageName : String, hightImageName : String, size : CGSize) ->UIBarButtonItem{
        let btn = UIButton.init()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0 ), size: size)
        let Item = UIBarButtonItem(customView: btn)
        return Item
    }
    
   // 集成拓展
    //便利构造函数 1》convenience开头   2》必须调用设置的构造函数 用self调用
    convenience init(imageName : String, hightImageName : String = "", size : CGSize = CGSize.zero) {
        
        let btn = UIButton.init()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        
        if size == CGSize.zero{
             btn.sizeToFit()
        } else {
             btn.frame = CGRect(origin: CGPoint(x: 0, y: 0 ), size: size)
        }
       
        
        self.init(customView:btn)
    }
}
