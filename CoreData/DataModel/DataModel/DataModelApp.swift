//
//  DataModelApp.swift
//  DataModel
//
//  Created by Thiago Pereira de Menezes on 15/08/23.
//

import SwiftUI

@main
struct DataModelApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
