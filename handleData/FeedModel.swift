//
//  FeedModel.swift
//  handleData
//
//  Created by gaoguangxiao on 2017/8/31.
//  Copyright © 2017年 gaoguangxiao. All rights reserved.
//

import Foundation
import SwiftyJSON
class FeedModel: GrandModel{
    //存储属性
    var image : String = ""
    var title : String = ""
    var url : String   = ""
    var link : String  = ""
    class func getDic(dic:JSON) -> FeedModel {
        let f = FeedModel.init()
        f.image = dic["image"].string!
        f.title = dic["title"].string!
        f.url   = dic["url"].string!
        f.link  = dic["link"].string!
        return f
    }
  
}
