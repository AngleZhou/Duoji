//
//  ObjectWrapper.swift
//  Duoji
//
//  Created by ZhouQian on 16/1/16.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation

class ObjectWrapper<T>:NSObject, NSCopying {
    var value: T
    init(value: T) {
        self.value = value
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return ObjectWrapper(value: self.value)
    }
}
