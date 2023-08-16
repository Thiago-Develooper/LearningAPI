//
//  dataController.swift
//  DataModel
//
//  Created by Thiago Pereira de Menezes on 15/08/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "dataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("O core data falou em seu carregamento, \(error.localizedDescription)")
            }
            
        }
    }
}
