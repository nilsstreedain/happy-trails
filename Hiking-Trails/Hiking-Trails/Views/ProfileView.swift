//
//  ProfileView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/15/22.
//

import SwiftUI
import CloudKit
import AuthenticationServices

struct SettingsView: View {
    var body: some View {
//        Text("Profile")
//                    .font(.system(size: 30, weight: .bold, design: .rounded))
        Form {
            Section(header: Text("ABOUT")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("2.2.1")
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct ProfileView: View {
    
    @State var username: String = ""
    @State var showingSettings = false
    @State var logOut = false

    var body: some View {
            
        NavigationView {

            Form {
                HStack {
                    Image("default_profile").frame(width: 60, height: 60).clipShape(Circle())
                    Spacer()
                    Text("Raffaele De Amicis").font(.system(size: 22, weight: .bold, design: .default))
                    Spacer()
                    Image(systemName: "arrow.right.circle")
                    
                }
                Section(header: Text("LIFETIME STATISTICS")) {
                    HStack {
                        Text("Distance")
                        Spacer()
                        Text("435 mi")
                    }
                    HStack {
                        Text("Elevation")
                        Spacer()
                        Text("12,465 ft")
                    }
                    HStack {
                        Text("Calories")
                        Spacer()
                        Text("25,634 kcal")
                    }
                }
//                Section(header: Text("ABOUT")) {
//                    HStack {
//                        Text("Version")
//                        Spacer()
//                        Text("2.2.1")
//                    }
//                }
                Button(action: {
                            self.showingSettings.toggle()
                        }) {
                            Text("Settings")
                        }.sheet(isPresented: $showingSettings) {
                            SettingsView()
                        }
                Section {
                    Button(action: {
                        self.logOut.toggle()
                    }) {
                        Text("Log Out").foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Profile")
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
