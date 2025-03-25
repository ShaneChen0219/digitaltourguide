//
//  DigitalTourApp.swift
//  DigitalTour
//
//  Created by Shane Chen on 3/24/25.
//

import SwiftUI

@main
struct DigitalTourApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                CitySelectionView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                LoginView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
