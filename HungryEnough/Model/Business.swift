//
//  Business.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 6/5/17.
//  Copyright © 2017 AwpSpace. All rights reserved.
//

import Foundation
import SwiftyJSON

class Business: Jsonable {

    var id = ""
    var name = ""
    var imageUrl = ""
    var isClosed = false
    var url = ""
    var categories = [BusinessCategory]()
    var rating = 0.0
    var latitide = 0.0
    var longitude = 0.0
    var price = ""
    var location = ""
    var phone = ""
    var displayPhone = ""
    var distance = 0.0

    required init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.imageUrl = json["image_url"].stringValue
        self.isClosed = json["is_closed"].boolValue
        self.url = json["url"].stringValue
        self.categories = json["categories"].arrayValue.map { BusinessCategory(json: $0) }
        self.rating = json["rating"].doubleValue
        self.latitide = json["coordinates"]["latitude"].doubleValue
        self.longitude = json["coordinates"]["longitude"].doubleValue
        self.price = json["price"].stringValue
        self.location = json["location"]["display_address"].stringValue
        self.phone = json["phone"].stringValue
        self.displayPhone = json["display_phone"].stringValue
        self.distance = json["distance"].doubleValue
    }
}
