//
//  CitySpots.swift
//  DigitalTour
//
//  Created by Shane Chen on 3/25/25.
//
import Foundation
import CoreLocation

struct Spot: Codable, Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let audioURL: String
    
    private enum CodingKeys: String, CodingKey {
        case name, address, latitude, longitude, audioURL
    }
}

func loadCities() -> [CitySpots] {
    guard let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
          let data = try? Data(contentsOf: url)
    else {
        print("cities.json not found in bundle")
        return []
    }
    do {
        // Decode into a [String: [Spot]] dictionary
        let decoded = try JSONDecoder().decode([String: [Spot]].self, from: data)
        
        // Transform into an array of CitySpots
        return decoded.map { (cityName, spots) in
            CitySpots(cityName: cityName, spots: spots)
        }
    } catch {
        print("Error decoding JSON: \(error)")
        return []
    }
}


struct CitySpots: Codable {
    let cityName: String
    let spots: [Spot]
}
