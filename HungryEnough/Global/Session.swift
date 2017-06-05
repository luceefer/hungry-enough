//
//  Session.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 6/5/17.
//  Copyright © 2017 AwpSpace. All rights reserved.
//

import Foundation
import Moya

class Session {

    static let shared = Session()

    var yelpClientId: String!
    var yelpClientSecret: String!

    var currentAuth: AuthResponse?

    static func initialize(yelpClientId: String, yelpClientSecret: String) {
        Session.shared.yelpClientId = yelpClientId
        Session.shared.yelpClientSecret = yelpClientSecret
    }

    func getCurrentAuth(callback: ((NSError?, AuthResponse?) -> Void)?) {
        if let currentAuth = self.currentAuth {
            callback?(nil, currentAuth)
            return
        }
        let provider = MoyaProvider<YelpApi>()
        provider.request(.auth(
            clientId: self.yelpClientId,
            clientSecret: self.yelpClientSecret)
        ) { (result) in
            switch result {
            case let .success(moyaResponse):
                let apiResponse = moyaResponse.mapApi()
                if let error = apiResponse.error {
                    callback?(error, nil)
                } else {
                    self.currentAuth = apiResponse.get(AuthResponse.self)
                    callback?(nil, self.currentAuth)
                }
            case let .failure(error):
                callback?(error as NSError, nil)
            }
        }
    }
}
