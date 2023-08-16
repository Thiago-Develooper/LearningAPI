//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by Thiago Pereira de Menezes on 15/08/23.
//

import SwiftUI

@main
struct CoreDataBootcampApp: App {
    //este let guarda a persitência deste controlado, logo em seguinda ela é colocada em .environment
    //esta let recebe este controlador que também armazena onsso container.
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                //Este environment faz com que todas as subviews dessa view tenham a todos os dados que colocamos no ambiente.
                //passamos como parâmetro a viewContext de container que é aonde temos realmente os dados do container.
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
