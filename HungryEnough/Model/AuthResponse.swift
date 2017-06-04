//
//  AuthResponse.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 5/31/17.
//  Copyright © 2017 HungryEnough. All rights reserved.
//

import Foundation
import SwiftyJSON

class AuthResponse: Jsonable {

    var token = ""
    var user: User

    required init(json: JSON) {
        self.token = json["token"].stringValue
        self.user = User(json: json["user"])
    }
}
