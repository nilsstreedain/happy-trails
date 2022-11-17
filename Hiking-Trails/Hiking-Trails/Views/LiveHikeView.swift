//
//  LiveHikeView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/11/22.
//

import SwiftUI
import MapKit

struct LiveHikeView: View {
	
	@ObservedObject var currHike = Current_Hike()
	
    var body: some View {
		VStack {
			MapUIView()
				.ignoresSafeArea()
			HStack() {
				Spacer()
				Label(String(format: "%02d", currHike.counter / 60) + ":" + String(format: "%02d", currHike.counter % 60), systemImage: "timer")
				Spacer()
				Label("0 MI", systemImage: "lines.measurement.horizontal")
				Spacer()
				Label("0'0\"/MI", systemImage: "figure.run")
				Spacer()
			}.padding(5)
			HStack() {
				Spacer()
				Label("0 CAL", systemImage: "flame")
				Spacer()
				Label("0 FT", systemImage: "mountain.2")
				Spacer()
			}.padding(5)
			HStack() {
				if currHike.mode == .stopped {
					hikeButton(label: "Start Hike", color: Color("AccentColor"), op: self.currHike.start)
				} else if currHike.mode == .started {
					hikeButton(label: "Pause Hike", color: Color.orange, op: self.currHike.pause)
					hikeButton(label: "End Hike", color: Color.red, op: self.currHike.reset)
				} else if currHike.mode == .paused {
					hikeButton(label: "Resume Hike", color: Color("AccentColor"), op: self.currHike.start)
					hikeButton(label: "End Hike", color: Color.red, op: self.currHike.reset)
				}
			}
		}
    }
}

struct LiveHikeView_Previews: PreviewProvider {
    static var previews: some View {
        LiveHikeView()
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
	@Published var counter: Int = 0
	@Published var mode: hikeMode = .stopped
	var timer = Timer()
	
	enum hikeMode {
		case started
		case paused
		case stopped
	}
	
	func start() {
		mode = .started
		self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
			self.counter += 1
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
