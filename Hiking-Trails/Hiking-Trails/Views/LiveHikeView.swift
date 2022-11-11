//
//  LiveHikeView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/11/22.
//

import SwiftUI

struct LiveHikeView: View {
    var body: some View {
		VStack {
			HStack() {
				Spacer()
				Label("Time", systemImage: "timer")
				Spacer()
				Label("Distance", systemImage: "lines.measurement.horizontal")
				Spacer()
				Label("Pace", systemImage: "figure.run")
				Spacer()
			}.padding(5)
			HStack() {
				Spacer()
				Label("Calories", systemImage: "flame")
				Spacer()
				Label("Elevation", systemImage: "mountain.2")
				Spacer()
			}.padding(5)
			MapUIView()
		}
    }
}

struct LiveHikeView_Previews: PreviewProvider {
    static var previews: some View {
        LiveHikeView()
    }
}
