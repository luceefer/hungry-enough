//
//  BusinessViewPresenter.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 6/5/17.
//  Copyright © 2017 AwpSpace. All rights reserved.
//

import Foundation

protocol BusinessView: BaseView {

    func close()

    func display(business: Business)
}

class BusinessViewPresenter: BasePresenter {

    weak var view: BusinessView?

    let business: Business

    init(view: BusinessView, business: Business) {
        self.view = view
        self.business = business
    }

    func load() {
        self.view?.display(business: self.business)
    }

    func close() {
        self.view?.close()
    }
}
