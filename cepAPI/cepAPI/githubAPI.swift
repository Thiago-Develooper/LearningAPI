import SwiftUI
import Foundation

struct GithubAPI: View {
    
    @State var serviceAPI:ServiceAPI?
    
    var body: some View {
        VStack {
            Text("Previsão do Tempo")
                .font(.title)
                .padding()
            
            Button("Obter Previsão") {
                serviceAPI?.get()
                
            }
        }
    }
    
//    func fetchWeatherData() {
//        let apiKey = "https://api.themotivate365.com/stoic-quote" // Substitua pela sua chave de API
//        let city = "NomeDaCidade"
//
//        // Construir a URL da API
//        let urlString = "https://api.themotivate365.com/stoic-quote"
//        guard let url = URL(string: urlString) else { return }
//
//        // Fazer a solicitação
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                do {
//                    // Decodificar os dados da resposta
//                    let weather = try JSONDecoder().decode(WeatherData.self, from: data)
//                    print(weather)
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume() // Iniciar a tarefa de solicitação
//    }
}

struct GithubAPI_Previews: PreviewProvider {
    static var previews: some View {
        GithubAPI()
    }
}
//
//struct WeatherData: Codable {
//    let quote: String
//
//}

struct Question: Codable {
    var question:String?
    var correct_answer:String?
    var incorrect_answers:String?
}

enum ErrorAPI: Error {
    case invalidURL
    case invalidResponce
    case invalidData
}

class ServiceAPI {
    private let endpoint = "https://opentdb.com/api.php?amount=1&category=22&difficulty=easy&type=boolean"
    
    func get() async throws -> Question {
        
        guard let url = URL(string: endpoint) else {
            throw ErrorAPI.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ErrorAPI.invalidResponce
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let question = try decoder.decode(Question.self, from: data)
            return question
        } catch {
            throw ErrorAPI.invalidData
        }
    }
}

do {
    let service = Service()
    let question = try await service.get()
    
    print("Question: \(question.question ?? "")")
} catch {
    print("Error: \(error)")
}


var caramba = ""
