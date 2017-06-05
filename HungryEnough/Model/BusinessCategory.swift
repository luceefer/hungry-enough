//
//  BusinessCategory.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 6/5/17.
//  Copyright © 2017 AwpSpace. All rights reserved.
//

import Foundation
import SwiftyJSON

class BusinessCategory: Jsonable {

    let alias: String
    let title: String

    required init(json: JSON) {
        self.alias = json["alias"].stringValue
        self.title = json["title"].stringValue
    }
}
