//: [Previous](@previous)

import Foundation

struct JokeResponse: Codable {
    let id: String
    let joke: String
    let status: Int
}


enum ErrorAPI: Error {
    case invalidURL
    case invalidResponce
    case invalidData
}

class Service {
    private let endpoint = """curl -H "Accept: application/json" https://icanhazdadjoke.com/"""
    
    func get() async throws -> JokeResponse {
        
        guard let url = URL(string: endpoint) else {
            throw ErrorAPI.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ErrorAPI.invalidResponce
        }
        
        do {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let question = try decoder.decode(JokeResponse.self, from: data)
            return question
        } catch {
            print("a cahpa")
            throw ErrorAPI.invalidData
        }
    }
}

do {
    let service = Service()
    let question = try await service.get()
    
    print("Question: \(question.joke)")
} catch {
    print("Error: \(error)")
}

//: [Next](@next)
