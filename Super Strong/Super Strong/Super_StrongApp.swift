//
//  Super_StrongApp.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/10/20.
//

import SwiftUI

@main
struct Super_StrongApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .inactive:
                try? persistenceController.container.viewContext.save()
            default:
                break
            }
        }
    }
}
