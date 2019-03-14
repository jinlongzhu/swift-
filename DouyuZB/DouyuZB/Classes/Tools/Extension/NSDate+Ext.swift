//
//  NSDate+Ext.swift
//  DouyuZB
//
//  Created by dingjunchuxing on 2019/3/14.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import Foundation

extension NSDate {
   
  class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
