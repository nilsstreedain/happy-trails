//
//  LiveHikeView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/11/22.
//

import SwiftUI

struct LiveHikeView: View {
	@ObservedObject var currHike = Current_Hike()
	
    var body: some View {
		VStack {
			currHike.map
				.ignoresSafeArea()
			HStack(spacing: 50) {
				Label(String(format: "%02d:%02d", Int(currHike.counter) / 60, Int(currHike.counter) % 60), systemImage: "timer")
				Label("0 MI", systemImage: "lines.measurement.horizontal")
				Label("0'0\"/MI", systemImage: "figure.run")
			}
			.padding(5)
			HStack(spacing: 50) {
				Label("0 CAL", systemImage: "flame")
				Label("+0 FT", systemImage: "mountain.2")
			}
			.padding(5)
			HStack() {
				if currHike.mode == .stopped {
					hikeButton(label: "Start Hike", color: Color("AccentColor"), op: self.currHike.start)
				} else if currHike.mode == .started {
					hikeButton(label: "Pause Hike", color: Color.orange, op: self.currHike.pause)
					hikeButton(label: "End Hike", color: Color.red, op: self.currHike.reset)
				} else if currHike.mode == .paused {
					hikeButton(label: "Resume Hike", color: Color.green, op: self.currHike.start)
					hikeButton(label: "End Hike", color: Color.red, op: self.currHike.reset)
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
	@Published var counter: Double = 0
	@Published var mode: hikeMode = .stopped
	@Published var map = MapUIView()
	var timer = Timer()
	
	enum hikeMode {
		case started
		case paused
		case stopped
	}
	
	func start() {
		mode = .started
		self.map.startPolyLine()
		self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
			self.counter += 1
			self.map.updatePolyLine()
		}
	}
	
	func pause() {
		mode = .paused
		self.timer.invalidate()
	}
	
	func reset() {
		mode = .stopped
		self.counter = 0
		self.timer.invalidate()
	}
}

struct LiveHikeView_Previews: PreviewProvider {
	static var previews: some View {
		LiveHikeView()
	}
}
