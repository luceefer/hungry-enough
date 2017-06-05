//
//  HomeController.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/11/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import UIKit
import Moya
import GoogleMaps

class HomeController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    var markers = [GMSMarker]()
    var presenter: HomePresenter?

    lazy var markerIcon: UIView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        view.image = UIImage(named: "Marker")
        view.contentMode = .scaleAspectFill
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUi()

        self.presenter?.startLocationRequest()
    }

    // MARK: - Private

    fileprivate func setupUi() {
        self.presenter = HomePresenter(
            view: self,
            provider: MoyaProvider<YelpApi>(endpointClosure: ServiceHelper.defaultEndpointClosure)
        )
        self.title = "Hungry Enough"
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        self.mapView.delegate = self.presenter
    }
}

// MARK: - HomeView

extension HomeController: HomeView {

    func show(loading: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        if loading {
            self.infoLabel.text = "Searching..."
            self.subtitleLabel.text = ""
        }
    }

    func show(error: String) {
        Tool.showError(error)
    }

    func viewBusiness(business: Business) {
    }

    func navigate(to position: GMSCameraPosition) {
        self.mapView.animate(to: position)
    }

    func show(result: SearchResult) {
        self.markers.forEach { $0.map = nil }
        self.markers.removeAll()
        self.markers = result.businesses.map { business -> GMSMarker in
            let position = CLLocationCoordinate2D(latitude: business.latitide, longitude: business.longitude)
            let marker = GMSMarker(position: position)
            marker.title = business.name
            marker.snippet = "Rating \(business.rating), \(business.isClosed ? "Closed :(" : "Opening!!!")"
            marker.iconView = self.markerIcon
            marker.map = self.mapView
            return marker
        }

        // display info
        if result.businesses.isEmpty {
            self.infoLabel.text = "Oops, nothing found"
            self.subtitleLabel.text = ""
        } else {
            self.infoLabel.text = "Anything interested?"
            self.subtitleLabel.text = "Found \(result.total) so far..."
        }
    }
}
