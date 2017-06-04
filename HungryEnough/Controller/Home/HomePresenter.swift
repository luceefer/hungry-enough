//
//  HomePresenter.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/13/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import Foundation

protocol HomeView: BaseView {

    func viewBusiness()
}

class HomePresenter: BasePresenter {

    weak var view: HomeView!

    init(view: HomeView) {
        self.view = view
    }
}
