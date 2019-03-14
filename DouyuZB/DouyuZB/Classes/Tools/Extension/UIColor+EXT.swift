//
//  UIColor+EXT.swift
//  DouyuZB
//
//  Created by 朱金龙 on 2019/3/10.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0,alpha : 1.0)
    }
}
