//
//  Array.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 5/22/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import Foundation

extension Array {

    func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}
