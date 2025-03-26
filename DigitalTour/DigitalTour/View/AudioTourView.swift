import SwiftUI
import AVKit

struct AudioTourView: View {
    let spot: Spot
    @State private var player: AVPlayer?
    @State private var isPlaying: Bool = false
    @State private var audioProgress: Double = 0.0
    
    var body: some View {
        VStack(spacing: 12) {
            // Progress bar (Slider) to show or control playback progress
            Slider(value: $audioProgress, in: 0...1)
            
            HStack(spacing: 40) {
                // Previous track button (optional)
                Button(action: {
                    // Implement previous track logic if needed
                }) {
                    Image(systemName: "backward.fill")
                        .font(.title)
                }
                
                // Play/Pause
                Button(action: {
                    if isPlaying {
                        player?.pause()
                    } else {
                        player?.play()
                    }
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                }
                
                // Next track button (optional)
                Button(action: {
                    // Implement next track logic if needed
                }) {
                    Image(systemName: "forward.fill")
                        .font(.title)
                }
            }
            
            // Spot name and status
            Text(spot.name)
                .font(.headline)
            Text(isPlaying ? "Audio Playing..." : "Audio Paused")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .onAppear {
            if let url = URL(string: spot.audioURL) {
                player = AVPlayer(url: url)
            }
        }
    }
}
