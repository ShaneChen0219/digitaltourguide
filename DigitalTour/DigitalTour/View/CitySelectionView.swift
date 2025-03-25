//
//  CitySelectionView.swift
//  DigitalTour
//
//  Created by Shane Chen on 3/25/25.
//
import SwiftUI

struct CitySelectionView: View {
    @State private var cities: [CitySpots] = []
    @State private var selectedCity: CitySpots?
    @State private var navigateToSpots = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = true
    
    var body: some View {
        NavigationStack {
            List(cities, id: \.cityName) { city in
                Button(action: {
                    selectedCity = city
                    navigateToSpots = true
                }) {
                    Text(city.cityName)
                }
            }
            .navigationTitle("Choose a City")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        isLoggedIn = false
                    }
                }
            }
            .onAppear {
                //TODO: Load from JSON or server
                self.cities = loadCities()
            }
            .navigationDestination(isPresented: $navigateToSpots) {
                if let city = selectedCity {
                    SpotsMapView(citySpots: city)
                } else {
                    EmptyView()
                }
            }
        }
    }
}
