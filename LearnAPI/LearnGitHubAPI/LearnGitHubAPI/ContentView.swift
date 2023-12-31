//
//  ContentView.swift
//  LearnGitHubAPI
//
//  Created by Thiago Pereira de Menezes on 16/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var user: GitHubUser?
    @State private var userFollowers: [GitHubUser]?
    @State private var userFollowing: [GitHubUser]?
    @State private var login: String = "Thiago-Develooper"
    @State private var followers: Bool = true
        
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)
            
            Text(user?.login ?? "N/A")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "")
            
            HStack {
                Spacer()

                Button {
                    followers = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundColor(
                                Color(.black)
                            )
                            .frame(width: 130, height: 40)
                        Text("Followers")
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Button {
                    followers = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundColor(
                                Color(.black)
                            )
                            .frame(width: 130, height: 40)
                        Text("Following")
                            .foregroundColor(.white)

                    }
                }
                
                Spacer()

            }
            
            

            
//            List {
//                ForEach(userFollowing ?? [], id: \.self) { follower in
//                    Text(follower.login)
//                }
//            }
//            NavigationLink(<#LocalizedStringKey#>) {
                ScrollView(showsIndicators: false) {
                    
                    if followers {
                        ForEach(userFollowing ?? [], id: \.self) { follower in
                            //                    Perfil(user: userFollowing[follower])
                            
                            //                    Text(follower.login)
                            Perfil(user: follower)
                            
                        }
                        .ignoresSafeArea(.all)
                    } else {
                        ForEach(userFollowers ?? [], id: \.self) { follower in
                            //                    Perfil(user: userFollowing[follower])
                            
                            //                    Text(follower.login)
                            Perfil(user: follower)
                            
                        }
                        .ignoresSafeArea(.all)
                    }
                    
                    
                    
//                }
            }
                
            
            
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
                userFollowers = try await getFollowers()
                userFollowing = try await getFollowing()
                
            } catch GHError.invalidURL {
                print("Invalid URL")
            } catch GHError.invalidData {
                print("Invalid response")
            } catch GHError.invalidResponce {
                print("Invalid data")
            } catch {
                print("Unexpected Error")
            }
        }
    }
    
    func getUser() async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/\(login)"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponce
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func getFollowers() async throws -> [GitHubUser] {
        let endpoint = "https://api.github.com/users/\(login)/followers"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponce
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([GitHubUser].self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func getFollowing() async throws -> [GitHubUser] {
        let endpoint = "https://api.github.com/users/\(login)/following"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponce
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([GitHubUser].self, from: data)
        } catch {
            throw GHError.invalidData
        }

    }
    
//    func getFollowersInformations() async throws ->
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
