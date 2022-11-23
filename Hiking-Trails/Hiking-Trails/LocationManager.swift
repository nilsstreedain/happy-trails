//
//  LocationManager.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/20/22.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
	private let manager = CLLocationManager()
	@Published var location = CLLocation(latitude: 0, longitude: 0)
	@Published var status: CLAuthorizationStatus?
	static let shared = LocationManager()
	
	override init() {
		super.init()
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.distanceFilter = kCLDistanceFilterNone
		manager.startUpdatingLocation()
		manager.delegate = self
	}
	
	func requestLocation() {
		manager.requestAlwaysAuthorization()
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		status = manager.authorizationStatus
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		self.location = location
	}
}
