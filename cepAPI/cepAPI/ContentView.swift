//
//  ContentView.swift
//  cepAPI
//
//  Created by Thiago Pereira de Menezes on 12/08/23.
//

import SwiftUI
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

struct ContentView: View {
    @State var cep: String = "01001000"

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Button("Chamar") {
                callService()
            }
        }
        .padding()
//        .onAppear {
//            // Não há mais chamada da API aqui
//        }
//        .onAppear(perform: callService) // Chamada de API aqui
    }

    func callService() {
        let service = Service()
        service.get(cep: cep) { result in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    print(error)

                case let .success(data):
                    print(data)
                    
                }
            }
        }
    }
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



