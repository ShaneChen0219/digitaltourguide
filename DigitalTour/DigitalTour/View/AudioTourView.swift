//
//  AudioTourView.swift
//  DigitalTour
//
//  Created by Shane Chen on 3/25/25.
//

import AVKit
import SwiftUI

struct AudioTourView: View {
    let spot: Spot
    @State private var player: AVPlayer?
    
    var body: some View {
        VStack(spacing: 20) {
            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 200)
            }
            
            Text("Now Listening to \(spot.name)")
                .font(.headline)
            
            Button("Play") {
                player?.play()
            }
            .padding()
            
            Button("Pause") {
                player?.pause()
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle(spot.name)
        .onAppear {
            if let url = URL(string: spot.audioURL) {
                player = AVPlayer(url: url)
            }
        }
    }
}
