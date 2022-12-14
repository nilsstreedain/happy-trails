//
//  ContentView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 10/27/22.
//

import SwiftUI
//import CoreData

struct ContentView: View {
	@State private var selectedTab = 0
	
	var body: some View {
		ZStack {
			TabView(selection: $selectedTab) {
				LiveHikeView()
					.tabItem {
						Label("Start Hike", systemImage: "map")
					}
					.tag(0)
				TrailView()
					.tabItem {
						Label("Trails", systemImage: "signpost.right.and.left.fill")
					}
					.tag(1)
				ProfileView()
					.tabItem {
						Label("Profile", systemImage: "person.crop.circle.fill")
					}
					.tag(2)
			}.onAppear() {
				UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
			}
			LocationRequestView()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
