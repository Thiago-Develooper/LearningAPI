//
//  ContentView.swift
//  API
//
//  Created by Thiago Pereira de Menezes on 11/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)
            
            
            Text(user?.login ?? "Login Placeholder")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "Bio Placeholder")
                .padding()
            
            Text(user?.type ?? "type not found")
            
            Text(user?.followingUrl ?? "following url not found")
            
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
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
    
    func getUser() async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/Thiago-Develooper"
        
        guard let url = URL(string: endpoint) else {
            throw CHError.invalidURL
            
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            ///decode: tenta decodificar os dados do formato JSON.
            return try decoder.decode(GitHubUser.self, from: data)
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

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String?
    let type: String
    let followingUrl: String
}

enum CHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
