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

    case logout
}

extension YelpApi: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.yelp.com")!
    }

    var path: String {
        return ""
    }

    var method: Moya.Method {
        return .post
    }

    var parameters: [String : Any]? {
        return nil
    }

    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
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
