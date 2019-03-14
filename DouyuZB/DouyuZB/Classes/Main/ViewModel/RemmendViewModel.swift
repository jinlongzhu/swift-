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
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    private lazy var  bigDataItem : AnchorGroup = AnchorGroup()
    private lazy var VerticalDataItem : AnchorGroup = AnchorGroup()
}

extension RemmendViewModel{
    
    func requstData(finishedCallback:@escaping () -> ()){
        //0 定义参数
        let param = ["limit": "4","offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
        
        //
        let GroupQueen = DispatchGroup()
        
        
        GroupQueen.enter()
        //1.请求推荐数据
        NetworkTools.requsetData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getBigDataRoom",parameters: param) { (result) in
            
            guard let resultDic = result as? [String:NSObject] else{
                return
            }
            guard let resultArry = resultDic["data"] as? [[String : NSObject]] else{
                return
            }
            
            
            
            self.bigDataItem.tag_name = "热门"
            self.bigDataItem.icon_url = "home_header_hot"
            
            
            for data in resultArry {
                let group = Room_listItem.init(dict: data)
                self.bigDataItem.anchors.append(group)
            }
            GroupQueen.leave()
             print("热门")
        }
        
        
        
        //2.请求颜值数据
        GroupQueen.enter()
        NetworkTools.requsetData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: param) { (result) in
            
            guard let resultDic = result as? [String:NSObject] else{
                return
            }
            guard let resultArry = resultDic["data"] as? [[String : NSObject]] else{
                return
            }
            
            
            self.VerticalDataItem.tag_name = "颜值"
            self.VerticalDataItem.icon_url = "home_header_phone"
            
            
            for data in resultArry {
                let group = Room_listItem.init(dict: data)
                self.VerticalDataItem.anchors.append(group)
            }
            
            GroupQueen.leave()
             print("颜值")
        }
        
        
        //3.请求后面部分的游戏数据
        GroupQueen.enter()
        NetworkTools.requsetData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: param) { (result) in
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

            GroupQueen.leave()
            print("请求后面部分的游戏数据")
        }
        
        
        GroupQueen.notify(queue: .main) {
             print("所有的任务执行完了")
            
            self.anchorGroups.insert(self.VerticalDataItem, at: 0)
            self.anchorGroups.insert(self.bigDataItem, at: 0)
            
            finishedCallback()
        }
        
    }
    
    
}


