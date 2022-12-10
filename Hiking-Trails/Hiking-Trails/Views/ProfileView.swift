//
//  ProfileView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/15/22.
//

import SwiftUI
import CloudKit

class CloudKitUserBootcampViewModel: ObservableObject {
	
	let container = CKContainer(identifier: "iCloud.nilsstreedain.Hiking-Trails.Trails")
	@Published var isSignedIn: Bool = false
	@Published var permissionStatus: Bool = false
	@Published var fName: String = "First"
	@Published var lName: String = "Last"
	
	init() {
		getiCloudStatus()
		requestPermission()
		fetchiCloudUserRecordID()
	}
	
	private func getiCloudStatus() {
		container.accountStatus { [weak self] returnedStatus, returnedError in
			DispatchQueue.main.async {
				if returnedStatus == .available {
					self?.isSignedIn = true
				}
			}
		}
	}
	
	func requestPermission() {
		container.requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
			DispatchQueue.main.async {
				if returnedStatus == .granted {
					self?.permissionStatus = true
				}
			}
		}
	}
	
	func fetchiCloudUserRecordID() {
		container.fetchUserRecordID { [weak self] returnedID, returnedError in
			if let id = returnedID {
				self?.discoveriCloudUser(id: id)
			}
		}
	}
	
	func discoveriCloudUser(id: CKRecord.ID) {
		container.discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
			DispatchQueue.main.async {
				if let name = returnedIdentity?.nameComponents?.givenName {
					self?.fName = name
				}
				if let name = returnedIdentity?.nameComponents?.familyName {
					self?.lName = name
				}
			}
		}
	}
}

struct ProfileView: View {
    
	@StateObject private var ckvm = CloudKitUserBootcampViewModel()
	var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)

    var body: some View {
        NavigationView {
			Form {
				HStack(alignment: .top) {
					VStack {
						Image("default_profile")
							.resizable()
							.frame(width: 130, height: 130)
							.clipShape(Circle())
						Text("\(ckvm.fName) \(ckvm.lName)").font(.system(size: 22, weight: .bold, design: .default))
					}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				.listRowInsets(EdgeInsets())
				.listRowBackground(Color(.systemGroupedBackground))
				
				Section(header: Text("Lifetime Statistics")) {
					LazyVGrid(columns: columns, spacing: 30) {
						ForEach(stats_Data) { stat in
							HStack {
								ZStack {
									Circle()
										.foregroundColor(Color(.systemGroupedBackground))
										.frame(width: 40)
									Image(systemName: stat.icon)
										.foregroundColor(Color.accentColor)
								}
								VStack(alignment: .leading) {
									Text(stat.title)
										.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
										.padding(.bottom, 0)
									Text(String(format: stat.format, stat.data))
										.font(.headline)
										.fontWeight(.bold)
										.foregroundColor(Color.accentColor)
										.padding(.top, 0)
								}
							}
						}
					}
				}
				Section(header: Text("Debug Info")) {
					HStack {
						Text("Version")
						Spacer()
						Text("\((Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String)!) (\((Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String)!))")
					}
					HStack {
						Text("iCloud Signed In")
						Spacer()
						Text(ckvm.isSignedIn.description)
					}
					HStack {
						Text("Permission Granted")
						Spacer()
						Text(ckvm.permissionStatus.description)
					}
				}
			}
			.navigationBarTitle("Profile")
		}
    }
}

struct stat : Identifiable {
	var id: Int
	var title: String
	var icon: String
	var format: String
	var data: Float
}

var stats_Data = [
	stat(id: 0, title: "Time", icon: "timer", format: "%.0f MIN", data: 197),
	stat(id: 1, title: "Distance", icon: "lines.measurement.horizontal", format: "%.2f MI", data: 9),
	stat(id: 2, title: "Calories", icon: "flame", format: "%.0f CAL", data: 4366),
	stat(id: 3, title: "Elevation", icon: "mountain.2", format: "%.0f'", data: 257)
]

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
