//
//  LocationManager.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/20/22.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
	private let manager = CLLocationManager()
	@Published var userLocation: CLLocation?
	static let shared = LocationManager()
	
	override init() {
		super.init()
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.startUpdatingLocation()
	}
	
	func requestLocation() {
		manager.requestAlwaysAuthorization()
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		
		switch status {
			
		case .notDetermined:
			print("DEBUG: Not detemined")
		case .restricted:
			print("DEBUG: Restricted")
		case .denied:
			print("DEBUG: Denied")
		case .authorizedAlways:
			print("DEBUG: Auth Always")
		case .authorizedWhenInUse:
			print("DEBUG: When In Use")
		@unknown default:
			break
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		self.userLocation = location
	}
}
