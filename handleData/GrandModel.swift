//
//  GrandModel.swift
//  handleData
//
//  Created by gaoguangxiao on 2017/8/31.
//  Copyright © 2017年 gaoguangxiao. All rights reserved.
//

import Foundation

class GrandModel:NSObject,NSCoding {
    override init() {
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        let properties = getSelfProperty()
        for propertyName in properties{
            let value = aDecoder.decodeObject(forKey: propertyName)
            self.setValue(value, forKey: propertyName)
        }
    }
    func encode(with aCoder: NSCoder) {
        let properties = getSelfProperty()
        for propertyName in properties{
            let value = self.value(forKey: propertyName)
            aCoder.encode(value, forKey: propertyName)
        }
    }
    //这里不能用静态方法，因为父类没法获取运行时的子类，只能获取运行时子类的实例
    func getSelfProperty()->[String]{
        var selfProperties = [String]()
        let cls = self.classForCoder
        var ivarsCnt : UInt32 = 0
        //　获取类成员变量列表，ivarsCnt为类成员数量
        let ivars = class_copyIvarList(cls, &ivarsCnt);
        for p in 0..<ivarsCnt {
            let ivar = ivars?[Int(p)]
            let n = String.init(cString: ivar_getName(ivar), encoding: String.Encoding.utf8)
            selfProperties.append(n!)
        }
        return selfProperties
    }
}
