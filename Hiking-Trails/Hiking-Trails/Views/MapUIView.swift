//
//  MapUIView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/10/22.
//

import SwiftUI
import MapKit

struct MapUIView: UIViewRepresentable {
	let locationManager = CLLocationManager()
	let mapView = MKMapView(frame: UIScreen.main.bounds)
	var mapPoints: [CLLocationCoordinate2D] = []
	
	func setupManager() {
		locationManager.requestWhenInUseAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = kCLDistanceFilterNone
		locationManager.startUpdatingLocation()
	}
	
	func makeUIView(context: Context) -> MKMapView {
		setupManager()
		mapView.delegate = context.coordinator
		mapView.isUserInteractionEnabled = false
		mapView.userTrackingMode = .followWithHeading
		mapView.showsUserLocation = true
		mapView.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1000, maxCenterCoordinateDistance: 1000), animated: false)
		
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {}
	
	mutating func startPolyline() {
		mapPoints.append(locationManager.location!.coordinate)
	}
	
	mutating func updatePolyline() {
		let curr = locationManager.location!
		let last = CLLocation(latitude: mapPoints.last!.latitude, longitude: mapPoints.last!.longitude)
		if last.distance(from: curr) > 5 {
			mapPoints.append(curr.coordinate)
			var area: [CLLocationCoordinate2D] = [mapPoints[mapPoints.count - 2], mapPoints.last!]
			mapView.addOverlay(MKPolyline(coordinates: &area, count: 2))
		}
	}
	
	mutating func resetPolyline() {
		mapPoints = []
		mapView.removeOverlays(mapView.overlays)
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
}

class Coordinator: NSObject, MKMapViewDelegate {
	var parent: MapUIView

	init(_ parent: MapUIView) { self.parent = parent }

	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if let routePolyline = overlay as? MKPolyline {
			let renderer = MKPolylineRenderer(polyline: routePolyline)
			renderer.strokeColor = UIColor.systemBlue
			renderer.lineWidth = 7
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
