//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by test on 11/7/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Todo.self)
    }
}
