//
//  HomePresenter.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/13/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol HomeView: BaseView {

    func viewBusiness()

    func navigate(to position: GMSCameraPosition)
}

class HomePresenter: NSObject, BasePresenter {

    weak var view: HomeView!

    let locationManager = CLLocationManager()

    init(view: HomeView) {
        self.view = view
    }

    func startLocationRequest() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - Private

    fileprivate func findNearbyBusiness(at position: GMSCameraPosition) {
        print(position)
    }
}

extension HomePresenter: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.findNearbyBusiness(at: position)
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
    }
}

extension HomePresenter: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            Tool.showError("Please allow me to access your location," +
                " thus I can give you a chance to get into an awesome restaurant :(")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let position = GMSCameraPosition.camera(
                withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 12.0)
            self.view?.navigate(to: position)
            self.locationManager.stopUpdatingLocation()
        }
    }
}
