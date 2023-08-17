//
//  DataController.swift
//  iCalories
//
//  Created by Thiago Pereira de Menezes on 17/08/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        ///Esse método carrega os armazenamentos persistentes do modelo de dados especificado.
        container.loadPersistentStores { desc, error in ///error: É um argumento que recebe qualquer erro que possa ocorrer durante o carregamento dos armazenamentos persistentes.
                                                       ///desc: É um argumento que recebe informações sobre o armazenamento persistente (normalmente você não precisaria usá-lo).
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    ///Função que salva os dados
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!!! WUHU!!!")
        } catch {
            print("We clould not save the data...")
        }
    }
    
    ///Função que adiciona comidas
    ///Tem como atributos, nome, calorias e context da comida
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context) //Inicializa
        
        //Instânciando atributos da função
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context) //Chamamos a função de salvar aqui dentro para economizar código.
    }
    
    ///Função que edita comidas
    ///Tem como atributos um tipo Food e os nome, calorias e context.
    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext) {
        
        //atribuindo novos dados ao tipo Food.
        food.id = UUID()
        food.name = name
        food.calories = calories
        food.date = Date()
        
        save(context: context) //Chamamos a função de salvar aqui dentro para economizar código.
    }
}
