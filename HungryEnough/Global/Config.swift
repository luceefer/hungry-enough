//
//  Config.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/3/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import Foundation

protocol Configuration {

    var apiRoot: String! { get }
}

class Config {

    static let shared = Config()

    let value: Configuration!

    init() {
        self.value = AppConfiguration.available[.production]
    }
}

// MARK: - Private

fileprivate enum Environment: String {

    case production = "Production"
}

fileprivate class AppConfiguration: Configuration {

    var apiRoot: String!
    var apiSubdomain: String!

    typealias AppConfigurationBuilderClosure = (AppConfiguration) -> Void

    init(build: AppConfigurationBuilderClosure) {
        build(self)
    }

    static var available: [Environment: Configuration] = {
        var environments = [Environment: Configuration]()

        // production
        environments[.production] = AppConfiguration(build: {
            $0.apiRoot = "http://HungryEnough.net/"
            $0.apiSubdomain = "http://%@.HungryEnough.net/"
        })

        return environments
    }()
}
