//
//  YelpApi.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 5/27/17.
//  Copyright © 2017 HungryEnough. All rights reserved.
//

import Foundation
import Moya

// MARK: - Moya's Targets

enum YelpApi {

    case auth(clientId: String, clientSecret: String)
    case search(latitude: Double, longitude: Double)
}

extension YelpApi: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.yelp.com/")!
    }

    var path: String {
        switch self {
        case .auth:
            return "oauth2/token"
        case .search:
            return "v3/businesses/search"
        }
    }

    var method: Moya.Method {
        switch self {
        case .auth:
            return .post
        case .search:
            return .get
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .auth(let clientId, let clientSecret):
            return [
                "client_id": clientId,
                "client_secret": clientSecret,
                "grant_type": "client_credentials"
            ]
        case .search(let latitude, let longitude):
            return [
                "latitude": latitude,
                "longitude": longitude
            ]
        }
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var task: Task {
        return .request
    }

    var sampleData: Data {
        return Data()
    }

    var validate: Bool {
        return false
    }
}
