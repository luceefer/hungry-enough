//
//  BusinessViewController.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 6/5/17.
//  Copyright © 2017 AwpSpace. All rights reserved.
//

import UIKit
import Kingfisher

class BusinessViewController: UIViewController {

    var presenter: BusinessViewPresenter!
    var business: Business?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = BusinessViewPresenter(view: self, business: self.business!)
    }
}

// MARK: - BusinessView

extension BusinessViewController: BusinessView {

    func close() {
        self.dismiss(animated: true, completion: nil)
    }

    func display(business: Business) {
        self.title = business.name
    }
}
