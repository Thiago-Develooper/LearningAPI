//
//  ContentView.swift
//  CoreDataBootcamp
//
//  Created by Thiago Pereira de Menezes on 15/08/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    //isso é uma solicitação de busca de adição com descritores de classificação
//    @FetchRequest(
//
//        //Isso classifica os dados da solicitação
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    //no primeiro parametro colocamos o tipo de entidade que queremos retornar
    //No segundo, informados como queremos classificar estes dados.
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: []) var fruits: FetchedResults<FruitEntity>

    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) { fruit in
                    Text(fruit.name ?? "")
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle(Text("Core Data Bootcamp"))
            .navigationBarItems(leading: EditButton(),
                               trailing:
                                Button(action: addItem) {
                                    Label("Add Item", systemImage: "plus")
            })
            
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = "Orange"
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)

            saveItems()
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
