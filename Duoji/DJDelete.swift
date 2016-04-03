//
//  DJDelete.swift
//  Duoji
//
//  Created by Zhou Qian on 16/4/3.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation

extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}