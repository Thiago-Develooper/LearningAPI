//
//  ContentView.swift
//  concelhosAPI
//
//  Created by Thiago Pereira de Menezes on 11/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var response:Countier?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Countier {
    
}
