//
//  NetworkTools.swift
//  DouyuZB
//
//  Created by dingjunchuxing on 2019/3/14.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requsetData(type : MethodType , urlString : String , parameters : [String : NSString]? = nil, finishedCallBlock : @escaping (_ result : AnyObject)->()){
        
        let methd = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: methd, parameters: parameters).responseJSON { (respose) in
              guard let result = respose.result.value else {
                print(respose.result.error ?? "报错")
                return
            }
            finishedCallBlock(result as AnyObject)
        }
    }
}
