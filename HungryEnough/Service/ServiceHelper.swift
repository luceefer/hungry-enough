//
//  ServiceHelper.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/21/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

struct ServiceHelper {

    static let errorServiceDomain = "net.awpspace.hungry-enough.error.service"

    static func defaultEndpointClosure<Target: TargetType>(target: Target) -> Endpoint<Target> {
        var headers = [String: String]()

        // authorization
        if let authResponse = Session.shared.currentAuth {
            headers["Authorization"] = "\(authResponse.tokenType) \(authResponse.accessToken)"
        }

        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        return defaultEndpoint.adding(newHTTPHeaderFields: headers)
    }
}
