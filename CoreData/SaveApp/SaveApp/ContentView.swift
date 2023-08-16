//
//  ContentView.swift
//  SaveApp
//
//  Created by Thiago Pereira de Menezes on 15/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var text:String = UserDefaults.standard.string(forKey: "TEXT_KEY") ?? ""
    @State var inputText:String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Input")) {
                TextField("Add some text here", text: $inputText)
            }
            
            Section(header: Text("Letter count:")) {
                let charCount = inputText.filter { $0 != " "}.count
                
                //se caracteres forem maior que trinta o texto ficará vermelho.
                if (charCount > 30) {
                    Text(String(charCount)).foregroundColor(.red)
                } else {
                    inputText == "" ? Text("Empty") : Text(String(charCount))
                }
            }
            
            Section(header: Text("Saved Data:")) {
                Text(text).lineLimit(3)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
