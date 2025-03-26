import MapKit
import SwiftUI

struct SpotsMapView: View {
    let citySpots: CitySpots
    
    // Store the initial region so we can reset later.
    private let initialRegion: MKCoordinateRegion
    
    // Center map on all spots in the city
    @State private var region: MKCoordinateRegion
    @State private var selectedSpot: Spot? = nil  // new state to track selected spot
    
    init(citySpots: CitySpots) {
        self.citySpots = citySpots
        
        if !citySpots.spots.isEmpty {
            // Compute bounding region for all spots
            let latitudes = citySpots.spots.map { $0.latitude }
            let longitudes = citySpots.spots.map { $0.longitude }
            let minLat = latitudes.min()!
            let maxLat = latitudes.max()!
            let minLon = longitudes.min()!
            let maxLon = longitudes.max()!
            
            let center = CLLocationCoordinate2D(
                latitude: (minLat + maxLat) / 2,
                longitude: (minLon + maxLon) / 2
            )
            // Multiply the span by 1.8 for some padding
            let span = MKCoordinateSpan(
                latitudeDelta: (maxLat - minLat) * 1.8,
                longitudeDelta: (maxLon - minLon) * 1.8
            )
            let computedRegion = MKCoordinateRegion(center: center, span: span)
            self.initialRegion = computedRegion
            _region = State(initialValue: computedRegion)
        } else {
            let defaultRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 40.0, longitude: -74.0),
                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            )
            self.initialRegion = defaultRegion
            _region = State(initialValue: defaultRegion)
        }
    }
    
    var body: some View {
        VStack {
            // Tappable header: when user taps on the city name,
            // the map resets to its initial region and clears selected spot.
            Button(action: {
                withAnimation {
                    region = initialRegion
                    selectedSpot = nil
                }
            }) {
                Text(citySpots.cityName)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            .padding(.top, 16)
            
            // Map with annotations on top
            Map(coordinateRegion: $region,
                annotationItems: citySpots.spots) { spot in
                MapMarker(
                    coordinate: CLLocationCoordinate2D(latitude: spot.latitude,
                                                         longitude: spot.longitude),
                    tint: .red
                )
            }
            .frame(height: 300)
            
            // Scrollable list of spots as buttons
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(citySpots.spots) { spot in
                        Button(action: {
                            DispatchQueue.main.async {
                                selectedSpot = spot
                                withAnimation {
                                    region.center = CLLocationCoordinate2D(latitude: spot.latitude,
                                                                           longitude: spot.longitude)
                                    // Zoom in to show roughly 5-10 streets
                                    region.span.latitudeDelta = 0.01
                                    region.span.longitudeDelta = 0.01
                                }
                            }
                        }) {
                            Text(spot.name)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 200)
            
            // Show the audio player below the list if a spot is selected.
            if let selectedSpot = selectedSpot {
                AudioTourView(spot: selectedSpot)
                    .transition(.slide)
            }
            
            Spacer()
        }
        .navigationTitle("") // Clear default navigation title if needed
    }
}
