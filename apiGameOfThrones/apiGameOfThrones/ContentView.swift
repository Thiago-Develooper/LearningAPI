//
//  ContentView.swift
//  apiGameOfThrones
//
//  Created by Thiago Pereira de Menezes on 14/08/23.
//

import SwiftUI

struct Character: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let title: String
    let family: String
    let image: String
    let imageUrl: String
}

enum CHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct ContentView: View {
    
    @State private var idCharacter:String? = "13"
    @State private var character: Character? 
    
    var body: some View {
        VStack {
            
            AsyncImage(url: URL(string: character?.imageUrl ?? "")) { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 400, height: 400)

            
            VStack(alignment: .leading) {
                Text("ID: \(character?.id ?? 0)")
                Text("First Name: \(character?.firstName ?? "Unknown")")
                Text("Last Name: \(character?.lastName ?? "Unknown")")
                Text("Full Name: \(character?.fullName ?? "Unknown")")
                Text("Title: \(character?.title ?? "Unknown")")
                Text("Family: \(character?.family ?? "Unknown")")
//                Text("Image: \(character?.image ?? "No Image")")
            }
            
            
            
//            Text("Image URL: \(character?.imageUrl ?? "No Image URL")")
            
        }
        .padding()
        .task {
            do {
                character = try await getCaracther(idCaracter: idCharacter ?? "1")
            } catch CHError.invalidURL {
                print("invalid URL")
            } catch CHError.invalidResponse {
                print("Invalid response")
            } catch CHError.invalidData {
                print("Invalid data")
            } catch {
                print("Unexpected error")
            }
        }
    }
    
    func getCaracther(idCaracter: String) async throws -> Character {
        let endpoint = "https://thronesapi.com/api/v2/Characters/\(idCaracter)"
        
        guard let url = URL(string: endpoint) else {
            throw CHError.invalidURL
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
            throw CHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            
            return try decoder.decode(Character.self, from: data)
        } catch {
            throw CHError.invalidData
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
