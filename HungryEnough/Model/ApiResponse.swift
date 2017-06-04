//
//  ApiResponse.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/6/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya

protocol Jsonable {

    init?(json: JSON)

    func export() -> JSON
}

extension Jsonable {

    func export() -> JSON {
        return .null
    }
}

// MARK: - Hungry Enough API Response

class ApiResponse {

    let error: NSError?
    let data: JSON?

    init(response: Response) {
        let json = JSON(response.data)
        if json["status"].exists() && json["status"].intValue == 0 {
            self.error = NSError(
                domain: ServiceHelper.errorServiceDomain,
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: json["message"].stringValue])
        } else {
            self.error = nil
        }
        if json["data"].exists() {
            self.data = json["data"]
        } else {
            self.data = json
        }
    }

    func get<T: Jsonable>(_ as: T.Type, keyPath: String? = nil) -> T? {
        guard let data = self.data else {
            return nil
        }
        if let keyPath = keyPath {
            return T(json: data[keyPath])
        } else {
            return T(json: data)
        }
    }

    func get<T: Jsonable>(_ as: [T.Type], keyPath: String? = nil) -> [T] {
        guard let data = self.data else {
            return []
        }
        if let keyPath = keyPath {
            return data[keyPath].arrayValue.flatMap { T(json: $0) }
        } else {
            return data.arrayValue.flatMap { T(json: $0) }
        }
    }
}

// MARK: - Moya Extension

extension Response {

    func mapApi() -> ApiResponse {
        return ApiResponse(response: self)
    }
}
