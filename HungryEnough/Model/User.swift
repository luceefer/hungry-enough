//
//  User.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/21/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: Jsonable {

    var id = 0

    required init(json: JSON) {
        self.id = json["id"].intValue
    }
}
