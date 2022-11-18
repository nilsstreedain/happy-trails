//
//  MapUIView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/10/22.
//

import SwiftUI
import MapKit

struct MapUIView: UIViewRepresentable {
	
	var mapPoints = [
		// Steve Jobs theatre
		CLLocationCoordinate2D(latitude: 37.330828, longitude: -122.007495),
		// Caffè Macs
		CLLocationCoordinate2D(latitude: 37.336083, longitude: -122.007356),
		// Apple wellness center
		CLLocationCoordinate2D(latitude: 37.336901, longitude:  -122.012345)
	];
	
	var locationManager = CLLocationManager()
	func setupManager() {
		locationManager.requestWhenInUseAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = kCLDistanceFilterNone
		locationManager.startUpdatingLocation()
	}
	
	func makeUIView(context: Context) -> MKMapView {
		setupManager()
		let mapView = MKMapView(frame: UIScreen.main.bounds)
		mapView.delegate = context.coordinator
		mapView.isUserInteractionEnabled = false
		mapView.userTrackingMode = .followWithHeading
		mapView.showsUserLocation = true
		mapView.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1000, maxCenterCoordinateDistance: 1000), animated: false)
		
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
}

class Coordinator: NSObject, MKMapViewDelegate {
	var parent: MapUIView

	init(_ parent: MapUIView) {
		self.parent = parent
	}

	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if let routePolyline = overlay as? MKPolyline {
			let renderer = MKPolylineRenderer(polyline: routePolyline)
			renderer.strokeColor = UIColor.systemBlue
			renderer.lineWidth = 10
			return renderer
		}
		return MKOverlayRenderer()
	}
}

struct MapUIView_Previews: PreviewProvider {
	static var previews: some View {
		MapUIView()
	}
}
