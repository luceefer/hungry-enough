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
import Moya
import SwiftyJSON
import Kingfisher

protocol HomeView: BaseView {

    func show(loading: Bool)

    func show(error: String)

    func viewBusiness(business: Business)

    func navigate(to position: GMSCameraPosition)

    func show(result: SearchResult)

    func buildInfoWindow(for business: Business) -> UIView?
}

class HomePresenter: NSObject, BasePresenter {

    weak var view: HomeView!
    var skipUpdate = false
    var searchResult: SearchResult? {
        didSet {
            if let searchResult = self.searchResult {
                self.view?.show(result: searchResult)
            }
        }
    }

    let provider: MoyaProvider<YelpApi>
    let locationManager = CLLocationManager()

    init(view: HomeView, provider: MoyaProvider<YelpApi>) {
        self.view = view
        self.provider = provider
    }

    func startLocationRequest() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - Private

    fileprivate func findNearbyBusiness(at position: GMSCameraPosition) {
        self.view?.show(loading: true)
        Session.shared.getCurrentAuth { (error, _) in
            self.view?.show(loading: false)

            if let error = error {
                self.view?.show(error: error.localizedDescription)
            } else {
                self.provider.request(.search(
                    latitude: position.target.latitude,
                    longitude: position.target.longitude
                ), completion: { (result) in
                    switch result {
                    case let .success(moyaResponse):
                        let apiResponse = moyaResponse.mapApi()
                        if let error = apiResponse.error {
                            self.view?.show(error: error.localizedDescription)
                        } else {
                            self.searchResult = apiResponse.get(SearchResult.self)
                        }
                    case let .failure(error):
                        self.view?.show(error: error.localizedDescription)
                    }
                })
            }
        }
    }
}

extension HomePresenter: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if !skipUpdate {
            self.findNearbyBusiness(at: position)
        } else {
            self.skipUpdate = false
        }
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let position = GMSCameraPosition.camera(
            withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: 14.0)

        self.skipUpdate = true
        mapView.selectedMarker = marker
        mapView.animate(to: position)
        return true
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let business = self.searchResult?.businesses.filter({ marker.snippet == $0.id }).first {
            self.view?.viewBusiness(business: business)
        }
    }

    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if let business = self.searchResult?.businesses.filter({ marker.snippet == $0.id }).first {
            marker.tracksInfoWindowChanges = true
            return self.view?.buildInfoWindow(for: business)
        }
        return nil
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
                withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 14.0)
            self.view?.navigate(to: position)
            self.findNearbyBusiness(at: position)
            self.locationManager.stopUpdatingLocation()
        }
    }
}
