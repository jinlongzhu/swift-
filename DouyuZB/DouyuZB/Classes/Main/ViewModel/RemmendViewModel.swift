//
//  RemmendViewModel.swift
//  DouyuZB
//
//  Created by dingjunchuxing on 2019/3/14.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit
import Alamofire
class RemmendViewModel{
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension RemmendViewModel{
    
    func requstData(){
        
        //1.请求推荐数据
        
        //2.请求颜值数据
        
        //3.请求后面部分的游戏数据
        NetworkTools.requsetData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit": "4","offset" : "0", "time" : NSDate.getCurrentTime() as NSString]) { (result) in
              //1.转字典
            guard let resultDic = result as? [String:NSObject] else{
                return
            }
            
            guard let resultArry = resultDic["data"] as? [[String : NSObject]] else{
                return
            }
            
            for dict in resultArry {
              let group = AnchorGroup.init(dict: dict)
                self.anchorGroups.append(group)
            }
            
            print(self.anchorGroups[0].anchors[0].room_id)
            
        }
    }
}
