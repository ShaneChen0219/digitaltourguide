//
//  AudioPlayerView.swift
//  DigitalTour
//
//  Created by Shane Chen on 3/24/25.
//
import SwiftUI
import AVKit

struct AudioPlayerView: View {
    @ObservedObject var viewModel: AudioViewModel
    let audioItem: Audio
    
    @State private var player: AVPlayer?
    
    var body: some View {
        VStack(spacing: 20) {
            // Use VideoPlayer to handle audio or video
            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 300)
            }
            
            HStack(spacing: 40) {
                Button("Play") {
                    player?.play()
                }
                .padding()
                .background(Color.blue.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Pause") {
                    player?.pause()
                }
                .padding()
                .background(Color.gray.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            Text("View Count: \(audioItem.viewCount)")
                .font(.headline)
            
            Spacer()
        }
        .navigationTitle(audioItem.title ?? "Audio")
        .padding()
        .onAppear {
            // Increment view count whenever the view appears
            viewModel.incrementViewCount(for: audioItem)
            
            // Configure the AVPlayer
            if let localPath = audioItem.localFilePath, !localPath.isEmpty {
                // For local file
                let fileURL = URL(fileURLWithPath: localPath)
                player = AVPlayer(url: fileURL)
            } else if let urlString = audioItem.audioURL, let url = URL(string: urlString) {
                // For remote URL
                player = AVPlayer(url: url)
            }
        }
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        
        // Create a mock item for preview
        let mockAudio = Audio(context: context)
        mockAudio.id = UUID()
        mockAudio.title = "Preview Audio"
        mockAudio.audioURL = "https://example.com/sample.mp3"
        mockAudio.viewCount = 5
        
        return AudioPlayerView(
            viewModel: AudioViewModel(context: context),
            audioItem: mockAudio
        )
    }
}
