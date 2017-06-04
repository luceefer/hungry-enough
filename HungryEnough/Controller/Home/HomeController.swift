//
//  HomeController.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/11/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!

    var presenter: HomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUi()

        self.presenter?.startLocationRequest()
    }

    // MARK: - Private

    fileprivate func setupUi() {
        self.presenter = HomePresenter(view: self)
        self.title = "Hungry Enough"
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        self.mapView.delegate = self.presenter
    }
}

// MARK: - HomeView

extension HomeController: HomeView {

    func viewBusiness() {
    }

    func navigate(to position: GMSCameraPosition) {
        self.mapView.animate(to: position)
    }
}
