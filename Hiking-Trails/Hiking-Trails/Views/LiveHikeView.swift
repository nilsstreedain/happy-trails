//
//  LiveHikeView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/11/22.
//

import SwiftUI
import MapKit

struct LiveHikeView: View {
    var body: some View {
		VStack {
			MapUIView()
				.ignoresSafeArea()
			HStack() {
				Spacer()
				Label("0:00:00", systemImage: "timer")
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
			Button {
//				saveUser()
			} label: {
				Text("Start Hike").frame(maxWidth: .infinity)
					.padding(5)
			}
			.buttonStyle(.borderedProminent)
			.padding(10)
		}
    }
}

struct LiveHikeView_Previews: PreviewProvider {
    static var previews: some View {
        LiveHikeView()
    }
}
