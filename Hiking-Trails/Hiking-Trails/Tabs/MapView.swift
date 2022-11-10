//
//  MapView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/10/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
	var locationManager = CLLocationManager()
	func setupManager() {
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestAlwaysAuthorization()
	}
	
	func makeUIView(context: Context) -> MKMapView {
		setupManager()
		let mapView = MKMapView(frame: UIScreen.main.bounds)
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .followWithHeading
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
	}
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
