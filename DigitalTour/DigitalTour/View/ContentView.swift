//
//  ContentView.swift
//  DigitalTour
//
//  Created by Shane Chen on 3/24/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var viewModel: AudioViewModel
    
    // Initialize with context
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: AudioViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.audioItems, id: \.self) { item in
                    NavigationLink(destination: AudioPlayerView(viewModel: viewModel, audioItem: item)) {
                        HStack {
                            Text(item.title ?? "Untitled")
                            Spacer()
                            Text("Views: \(item.viewCount)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.audioItems[$0] }
                        .forEach(viewModel.deleteItem)
                }
            }
            .navigationTitle("Audio Tours")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addSampleAudio) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addSampleAudio() {
        viewModel.addAudio(
            title: "Sample Audio",
            audioURL: "https://example.com/sample.mp3",
            localFilePath: nil
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(context: PersistenceController.shared.container.viewContext)
    }
}
