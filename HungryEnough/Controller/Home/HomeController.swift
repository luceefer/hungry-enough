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
import Kingfisher

class HomeController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    var markers = [GMSMarker]()
    var presenter: HomePresenter?
    var targetBusiness: Business?

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBusinessView", let vc = segue.destination as? BusinessViewController {
            vc.business = self.targetBusiness
            self.targetBusiness = nil
        }
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
        self.targetBusiness = business
        self.performSegue(withIdentifier: "showBusinessView", sender: nil)
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
            marker.snippet = "\(business.id)"
            marker.iconView = self.markerIcon
            marker.map = self.mapView
            marker.appearAnimation = .pop
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

    func buildInfoWindow(for business: Business) -> UIView? {
        if let view = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?[0] as? InfoWindow {
            view.nameLabel.text = business.name
            view.logoImageView.contentMode = .scaleAspectFit
            view.logoImageView.clipsToBounds = true
            view.logoImageView.kf.setImage(with: URL(string: business.imageUrl), placeholder: UIImage(named: "Marker"))
            view.ratingLabel.text = String(format: "%.1f", business.rating)
            view.addressLabel.text = business.location

            view.frame = CGRect(x: 0, y: 0, width: 180, height: 160)
            view.layer.cornerRadius = 4
            view.clipsToBounds = true
            view.layer.shadowOffset = CGSize(width: 2, height: 2)
            view.layer.shadowColor = UIColor.darkGray.cgColor
            return view
        }
        return nil
    }
}
