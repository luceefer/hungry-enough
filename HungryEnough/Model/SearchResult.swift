//
//  SearchResult.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 6/5/17.
//  Copyright © 2017 AwpSpace. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchResult: Jsonable {

    let businesses: [Business]
    let total: Int

    required init(json: JSON) {
        self.businesses = json["businesses"].arrayValue.map { Business(json: $0) }
        self.total = json["total"].intValue
    }
}
