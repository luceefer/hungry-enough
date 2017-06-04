//
//  HomeController.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/11/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeController: BaseTabBarController {

    var presenter: HomePresenter?
    var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(view: self)

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        self.mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        self.view.addSubview(self.mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
}

// MARK: - HomeView

extension HomeController: HomeView {

    func viewBusiness() {
    }
}
