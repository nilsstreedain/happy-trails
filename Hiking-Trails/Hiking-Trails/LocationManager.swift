//
//  LocationManager.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/20/22.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
	private let manager = CLLocationManager()
	@Published var location: CLLocation?
	@Published var status = false
	static let shared = LocationManager()
	
	override init() {
		super.init()
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.distanceFilter = kCLDistanceFilterNone
//		manager.requestAlwaysAuthorization()
		manager.startUpdatingLocation()
		manager.delegate = self
	}
	
	func requestLocation() {
		manager.requestAlwaysAuthorization()
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		switch manager.authorizationStatus {
		case .notDetermined , .restricted , .denied:
			status = false
		case .authorizedAlways , .authorizedWhenInUse:
			status = true
		default:
			status = false
		}
	}
	
//	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//		self.status = status
//		switch status {
//
//		case .notDetermined:
//			print("DEBUG: Not detemined")
//		case .restricted:
//			print("DEBUG: Restricted")
//		case .denied:
//			print("DEBUG: Denied")
//		case .authorizedAlways:
//			print("DEBUG: Auth Always")
//		case .authorizedWhenInUse:
//			print("DEBUG: When In Use")
//		@unknown default:
//			break
//		}
//	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		self.location = location
	}
}
