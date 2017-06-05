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

    var accessToken = ""
    var expiresIn = 0
    var tokenType = ""

    required init(json: JSON) {
        self.accessToken = json["access_token"].stringValue
        self.expiresIn = json["expires_in"].intValue
        self.tokenType = json["token_type"].stringValue
    }
}
