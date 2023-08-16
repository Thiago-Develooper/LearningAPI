//
//  ContentView.swift
//  DataModel
//
//  Created by Thiago Pereira de Menezes on 15/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            
            List(students) { sstudent in
                Text(sstudent.name ?? "unknow")
            }
            
            Button("Add") {
                let firstName = ["João", "Luca", "Thiago", "Gabriel"]
                let secondName = ["Lacerda", "Berald", "Menezes", "Eduardo"]
                
                let chosenFistName = firstName.randomElement()!
                let chosenLastName = secondName.randomElement()!
                
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenFistName) \(chosenLastName)"
                
//                do {
//                    try moc.save()
//                } catch {
//                    return
//                }
                
                try? moc.save()
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataController())
    }
}
