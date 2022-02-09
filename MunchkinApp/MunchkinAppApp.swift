//
//  MunchkinAppApp.swift
//  MunchkinApp
//
//  Created by Kostya Tsyvilko on 6.02.22.
//

import SwiftUI

@main
struct MunchkinAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(winnerInfo: WinnerInfo())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
