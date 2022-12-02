//
//  LiveHikeView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/11/22.
//

import SwiftUI

struct LiveHikeView: View {
	@ObservedObject var hikeView = Current_Hike()
	@ObservedObject var locationManager = LocationManager.shared
	
	var body: some View {
		if (locationManager.status == .authorizedAlways || locationManager.status == .authorizedWhenInUse) {
			VStack {
				hikeView.map
					.ignoresSafeArea()
				HStack(spacing: 50) {
					Label(String(format: "%02d:%02d", Int(hikeView.counter) / 60, Int(hikeView.counter) % 60), systemImage: "timer")
					Label(String(format: "%.2f MI", hikeView.distance), systemImage: "lines.measurement.horizontal")
					Label(String(format: "%1d'%02d\"/MI", Int(hikeView.pace) / 60, Int(hikeView.pace) % 60), systemImage: "figure.run")
				}
				.padding(5)
				HStack(spacing: 50) {
					Label("0 CAL", systemImage: "flame.fill")
					Label(String(format: "%.0f' | %.0f'", hikeView.map.getElevation(), hikeView.elvGain), systemImage: "mountain.2.fill")
				}
				.padding(5)
				HStack() {
					if hikeView.mode == .stopped {
						hikeButton(label: "Start Hike", color: Color("AccentColor"), op: hikeView.start)
					} else if hikeView.mode == .started {
						hikeButton(label: "Pause Hike", color: Color.orange, op: hikeView.pause)
						hikeButton(label: "End Hike", color: Color.red, op: hikeView.reset)
					} else if hikeView.mode == .paused {
						hikeButton(label: "Resume Hike", color: Color.green, op: hikeView.start)
						hikeButton(label: "End Hike", color: Color.red, op: hikeView.reset)
					}
				}
			}
		}
	}
}

struct hikeButton: View {
	let label: String
	let color: Color
	let op: () -> ()
	
	var body: some View {
		Button(action: {op()}) {
			Text(label)
			.frame(maxWidth: .infinity)
			.padding(5)
		}
		.buttonStyle(.borderedProminent)
		.accentColor(color)
		.padding(10)
	}
}

class Current_Hike: ObservableObject {
	@Published var mode: hikeMode = .stopped
	@Published var counter = 0.0
	@Published var distance = 0.0
	@Published var pace = 0.0
	@Published var elvGain = 0.0
	@Published var map = MapUIView()
	var timer = Timer()

	enum hikeMode {
		case started
		case paused
		case stopped
	}

	func start() {
		mode = .started
		map.startTracking()
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
			self.counter += 1
			self.distance += self.map.updateTracking()
			self.elvGain = self.map.getElevationGain()
			if self.distance > 0 {
				self.pace = self.counter / self.distance
			}
		}
	}

	func pause() {
		mode = .paused
		timer.invalidate()
	}

	func reset() {
		mode = .stopped
		counter = 0
		distance = 0
		elvGain = 0
		pace = 0
		timer.invalidate()
		map.resetTracking()
	}
}

struct LiveHikeView_Previews: PreviewProvider {
	static var previews: some View {
		LiveHikeView()
	}
}
