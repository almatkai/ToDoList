//
//  TodoListApp.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    @StateObject private var realmManager = RealmManager.shared
    let app = App(id: "application-0-erriu")
    
    var body: some Scene {
        WindowGroup {
            VStack {
                
                if let configuration = realmManager.configuration, let realm = realmManager.realm {
                    ContentView(app)
                        .environment(\.realmConfiguration, configuration)
                        .environment(\.realm, realm)
                }
                
                
            }.task {
                try? await realmManager.initialize()
            }
        }
    }
}
