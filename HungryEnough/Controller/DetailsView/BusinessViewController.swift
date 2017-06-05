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

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!

    var presenter: BusinessViewPresenter!
    var business: Business?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = BusinessViewPresenter(view: self, business: self.business!)
        self.presenter.load()
    }
}

// MARK: - BusinessView

extension BusinessViewController: BusinessView {

    func close() {
        self.navigationController?.popViewController(animated: true)
    }

    func display(business: Business) {
        self.title = business.name
        self.logoImageView.kf.setImage(with: URL(string: business.imageUrl), placeholder: UIImage(named: "Marker"))
        self.locationLabel.text = business.location
        self.phoneNumberLabel.text = business.displayPhone
        self.categoriesLabel.text = business.categories.map { $0.title }.joined(separator: ", ")
    }
}
