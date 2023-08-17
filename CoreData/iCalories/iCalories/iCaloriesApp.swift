//
//  iCaloriesApp.swift
//  iCalories
//
//  Created by Thiago Pereira de Menezes on 17/08/23.
//

import SwiftUI

@main
struct iCaloriesApp: App {
    
    ///Variável dataController do tipo DataController que será passada para todo o app.
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                //Aqui injetamos o nosso coreData em todo nosso app, fazendo que ele possa ser usado em qualquer lugar.
                ///Injeta core data em todo o app, fazendo que o coreData funcione em qualquer lugar dele.
                .environment(\.managedObjectContext, dataController.container.viewContext)
                //Em todos os lugares dentro do projeto o dataController.container.viewContext será referenciado como managedObjectContext.
        }
    }
}
