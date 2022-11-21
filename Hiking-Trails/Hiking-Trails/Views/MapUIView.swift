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
	var mapPoints: [CLLocation] = []
	
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
	
	mutating func startTracking() {
		mapPoints.append(locationManager.location!)
	}
	
	mutating func updateTracking() -> Double {
		let curr = locationManager.location!
		let dist = mapPoints.last!.distance(from: curr)
		if dist > 5 {
			mapPoints.append(curr)
			mapView.addOverlay(MKPolyline(coordinates: mapPoints.suffix(2).map { $0.coordinate }, count: 2))
			return Measurement(value: dist, unit: UnitLength.meters).converted(to: .miles).value
		}
		
		return 0
	}
	
	mutating func resetTracking() {
		mapView.removeOverlays(mapView.overlays)
		mapPoints = []
	}
	
	func getElevation() -> Double {
		return Measurement(value: locationManager.location!.altitude, unit: UnitLength.meters).converted(to: .feet).value
	}
	
	func getElevationGain() -> Double {
			return Measurement(value: locationManager.location!.altitude - mapPoints[0].altitude, unit: UnitLength.meters).converted(to: .feet).value
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
	
//	func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//		let curr = userLocation.location
//		if (parent.tracking && curr != nil && curr!.horizontalAccuracy <= 50.0) {
//			mapPoints.append(curr!)
//			if (mapPoints.count > 1) {
//				var area: [CLLocationCoordinate2D] = [mapPoints[mapPoints.count - 2].coordinate, mapPoints.last!.coordinate]
//				mapView.addOverlay(MKPolyline(coordinates: &area, count: 2))
//			}
//		}
//	}
}

struct MapUIView_Previews: PreviewProvider {
	static var previews: some View {
		MapUIView()
	}
}
