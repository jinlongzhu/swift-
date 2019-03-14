//
//  AnchorGroup.swift
//  DouyuZB
//
//  Created by dingjunchuxing on 2019/3/14.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit

@objcMembers
class AnchorGroup: NSObject {
    var icon_url: String = "home_header_normal"
    var small_icon_url: String!
    var tag_name: String = ""
    var tag_id: String = ""
    var push_vertical_screen: String = ""
    var push_nearby: String = ""
    var room_list: [[String : NSObject]]? {
        
        didSet {
            guard room_list != nil else {
                return
            }
            for model in room_list ?? []{
                anchors.append(Room_listItem(dict: model))
            }
            
            
          }
    }
    
   lazy var anchors : [Room_listItem] = [Room_listItem]()
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        ///这句话很关键,一定要有
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
       
    }
  
}
@objcMembers
class Room_listItem    : NSObject {
    
    var nickname: String!
    var room_id: Int = 0
    var vertical_src: String!
    var online: Int = 0
    var anchor_city: String = ""
    var isVertical: Int = 0
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        ///这句话很关键,一定要有
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
       
    }
}
