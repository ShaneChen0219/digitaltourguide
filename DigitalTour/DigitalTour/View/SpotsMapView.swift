//
//  SpotsMapView.swift
//  DigitalTour
//
//  Created by Shane Chen on 3/25/25.
//

import MapKit
import SwiftUI

struct SpotsMapView: View {
    let citySpots: CitySpots
    
    // Center map on the first spot or a default coordinate
    @State private var region: MKCoordinateRegion
    
    init(citySpots: CitySpots) {
        self.citySpots = citySpots
        
        // Default to first spot or fallback
        if let first = citySpots.spots.first {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: first.latitude, longitude: first.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            ))
        } else {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 40.0, longitude: -74.0),
                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            ))
        }
    }
    
    var body: some View {
        VStack {
            // List of spots
            List(citySpots.spots) { spot in
                NavigationLink(destination: AudioTourView(spot: spot)) {
                    Text(spot.name)
                }
            }
            .frame(height: 300) // or use flexible layout as needed
            
            // Map with annotations
            Map(coordinateRegion: $region,
                annotationItems: citySpots.spots) { spot in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: spot.latitude,
                                                             longitude: spot.longitude),
                          tint: .red)
            }
        }
        .navigationTitle(citySpots.cityName)
    }
}
