//
//  TrailView.swift
//  Hiking-Trails
//
//  Created by Nils Streedain on 11/9/22.
//

import SwiftUI

//private let itemFormatter: DateFormatter = {
//	let formatter = DateFormatter()
//	formatter.dateStyle = .short
//	formatter.timeStyle = .medium
//	return formatter
//}()

struct CardView: View {
    var image: String
    var trailName: String
    var trailLocation: String
    var trailStats: String
    var trailURL: String
    
    var body: some View {
        Link(destination: URL(string: trailURL)!) {
            VStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HStack {
                    VStack(alignment: .leading) {
                        Text(trailName)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text(trailLocation)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(trailStats.uppercased())
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red:150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            )
            .padding([.top, .horizontal])
        }
    }
}

struct TrailView: View {
    var body: some View {
        ScrollView {
            VStack {
//                Text("Trails").font(.headline).bold()
                CardView(image: "bald_hill", trailName: "Bald Hill Trail", trailLocation: "Corvallis, OR", trailStats: "2.7 mi, 450 ft, 1 hr 15 min", trailURL: "https://maps.apple.com/?address=Bald%20Hill%20Natural%20Area,%20Corvallis,%20OR%20%2097330,%20United%20States&auid=11750033503662115623&ll=44.568650,-123.333631&lsp=9902&q=Bald%20Hill%20Natural%20Area")
                CardView(image: "calloway", trailName: "Calloway Loop Trail", trailLocation: "Adair Village, OR", trailStats: "3.2 mi, 380 ft, 1 hr 20 min", trailURL: "https://maps.apple.com/?address=8692%20NW%20Peavy%20Arboretum%20Rd,%20Corvallis,%20OR%20%2097330,%20United%20States&auid=11070974604138884222&ll=44.658710,-123.235166&lsp=9902&q=Peavy%20Arboretum")
                CardView(image: "dans", trailName: "Dan's Trail", trailLocation: "Corvallis, OR", trailStats: "7.6 mi, 1581 ft, 3 hr 50 min", trailURL: "https://maps.apple.com/?address=Timberhill%20Natural%20Area,%20NW%2029th%20St,%20Corvallis,%20OR%20%2097330,%20United%20States&ll=44.603608,-123.287392&q=Dropped%20Pin")
                CardView(image: "fitton", trailName: "Fitton Green Trail", trailLocation: "Corvallis, OR", trailStats: "5.0 mi, 1190 ft, 2 hr 40 min", trailURL: "https://maps.apple.com/?address=980%20NW%20Panorama%20Dr,%20Corvallis,%20OR%20%2097330,%20United%20States&auid=13832141422784057030&ll=44.578362,-123.374140&lsp=9902&q=Fitton%20Green%20Natural%20Area")
                CardView(image: "mcculloch", trailName: "McCulloch Peak Trail", trailLocation: "Corvallis, OR", trailStats: "7.1 mi, 1712 ft, 3 hr 51 min", trailURL: "https://maps.apple.com/?address=NW%20Oak%20Creek%20Dr,%20Corvallis,%20OR%20%2097330,%20United%20States&ll=44.605168,-123.332243&q=Dropped%20Pin")
                CardView(image: "old_growth", trailName: "Old Growth Trail", trailLocation: "Corvallis, OR", trailStats: "1.5 mi, 249 ft, 42 min", trailURL: "https://maps.apple.com/?address=2778%20NW%20Sulphur%20Springs%20Rd,%20Corvallis,%20OR%20%2097330,%20United%20States&auid=4269859565762268600&ll=44.634720,-123.286944&lsp=9902&q=Lewisburg%20Saddle%20Trailhead")
                CardView(image: "vineyard", trailName: "Vineyard Mtn Loop", trailLocation: "Corvallis, OR", trailStats: "3.3 mi, 521 ft, 1 hr 30 min", trailURL: "https://maps.apple.com/?address=2778%20NW%20Sulphur%20Springs%20Rd,%20Corvallis,%20OR%20%2097330,%20United%20States&auid=4269859565762268600&ll=44.634720,-123.286944&lsp=9902&q=Lewisburg%20Saddle%20Trailhead")

        }
    }
        
    }
}

//struct TrailView: View {
//	@Environment(\.managedObjectContext) private var viewContext
//
//	@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], animation: .default)
//
//	private var items: FetchedResults<Item>
//
//	var body: some View {
//		NavigationView {
//			List {
//				ForEach(items) { item in
//					NavigationLink {
//						Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//					} label: {
//						Text(item.timestamp!, formatter: itemFormatter)
//					}
//				}
//				.onDelete(perform: deleteItems)
//			}
//			.toolbar {
//				ToolbarItem(placement: .navigationBarTrailing) {
//					EditButton()
//				}
//				ToolbarItem {
//					Button(action: addItem) {
//						Label("Add Item", systemImage: "plus")
//					}
//				}
//			}
//			Text("Select an item")
//		}
//	}
//
//	private func addItem() {
//		withAnimation {
//			let newItem = Item(context: viewContext)
//			newItem.timestamp = Date()
//
//			do {
//				try viewContext.save()
//			} catch {
//				// Replace this implementation with code to handle the error appropriately.
//				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//				let nsError = error as NSError
//				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//			}
//		}
//	}
//
//	private func deleteItems(offsets: IndexSet) {
//		withAnimation {
//			offsets.map { items[$0] }.forEach(viewContext.delete)
//
//			do {
//				try viewContext.save()
//			} catch {
//				// Replace this implementation with code to handle the error appropriately.
//				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//				let nsError = error as NSError
//				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//			}
//		}
//	}
//}

struct TrailView_Previews: PreviewProvider {
	static var previews: some View {
        TrailView()
	}
}
