//: [Previous](@previous)

import Foundation

struct Address: Codable {
    let zipcode: String
    let address: String
    let city: String
    let uf: String
    let complement: String?
    
    enum CodingKeys: String, CodingKey {
        case zipcode = "cep"
        case address = "logradouro"
        case city = "localidade"
        case uf
        case complement = "complemento"
    }
}

enum ServiceError: Error {
    case invalidURL
    case decodeFail(Error)
    case network(Error?)
}


class Service {
    ///corpo do endpoint
    private let baseURL = "https://viacep.com.br/ws"
    
    func get(cep: String, callback: @escaping (Result<Any, ServiceError>) -> Void) {
        let path = "/\(cep)/json"
        
        //cria url e verifica se ela é válida.
        guard let url = URL(string: baseURL + path) else {
            callback(.failure(.invalidURL))
            return
            
        }
        
        //A clourure da task só será executada quando a ação de download de dados for concluída.
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //Verifica de algum dado foi retornado da resonce
            guard let data = data else {
                callback(.failure(.network(error)))
                return
           
            }
            
            do {
                let address = try JSONDecoder().decode(Address.self, from: data)//retorna um objeto instânciado do tipo que você definiu
                callback(.success(address))

            } catch {
                callback(.failure(.decodeFail(error)))
            }
            
        }
        task.resume()
    }
}

do {
    let service = Service()
    service.get(cep: "01001000") { result in
        DispatchQueue.main.async { //cria nova thread e depois volta novamente para a trhead principal e printa a informação.
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                print(data) //printa os dados da requisição
            }
        }
    }
}




//: [Next](@next)


 
// func getUser() async throws -> GitHubUser {
//     let endpoint = "https://api.github.com/users/Thiago-Develooper"
//     
//     guard let url = URL(string: endpoint) else {
//         throw CHError.invalidURL
//         
//     }
//     
//     let (data, response) = try await URLSession.shared.data(from: url)
//    
//     guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//         throw CHError.invalidResponse
//     }
//     
//     do {
//         let decoder = JSONDecoder()
//         decoder.keyDecodingStrategy = .convertFromSnakeCase
//         
//         ///decode: tenta decodificar os dados do formato JSON.
//         return try decoder.decode(GitHubUser.self, from: data)
//     } catch {
//         throw CHError.invalidData
//     }
// }
//}
//
//struct ContentView_Previews: PreviewProvider {
// static var previews: some View {
//     ContentView()
// }
//}
//
//struct GitHubUser: Codable {
// let login: String
// let avatarUrl: String
// let bio: String?
// let type: String
// let followingUrl: String
//}
//
//enum CHError: Error {
// case invalidURL
// case invalidResponse
// case invalidData
//}

 
 
