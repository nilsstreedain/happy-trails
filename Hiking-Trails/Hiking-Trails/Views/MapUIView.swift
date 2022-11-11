//
//  MapUIView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/10/22.
//

import SwiftUI
import MapKit

struct MapUIView: UIViewRepresentable {
	var locationManager = CLLocationManager()
	func setupManager() {
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestAlwaysAuthorization()
	}
	
	func makeUIView(context: Context) -> MKMapView {
		setupManager()
		let mapView = MKMapView(frame: UIScreen.main.bounds)
		mapView.isUserInteractionEnabled = false;
		mapView.userTrackingMode = .followWithHeading
		mapView.showsUserLocation = true
		
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {}
}

struct MapUIView_Previews: PreviewProvider {
    static var previews: some View {
		MapUIView()
    }
}
