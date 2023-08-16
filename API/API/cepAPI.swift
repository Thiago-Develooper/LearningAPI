//
//  cepAPI.swift
//  API
//
//  Created by Thiago Pereira de Menezes on 14/08/23.
//

import SwiftUI

struct Address: Codable {
    let cep: String
    let logradouro: String?
    let complemento: String?
    let bairro: String?
    let localidade: String?
    let uf: String?
    let ibge: String?
    let gia: String?
    let ddd: String?
    let siafi: String?
}

struct cepAPI: View {
    
    @State private var address:Address?
    @State private var cep:String = "01001000"
    
    var body: some View {
        VStack {
            //            Text("CEP: \(address?.cep)")
                        Text("Logradouro: \(address?.logradouro ?? "N/A")")
                        Text("Complemento: \(address?.complemento ?? "N/A")")
                        Text("Bairro: \(address?.bairro ?? "N/A")")
                        Text("Localidade: \(address?.localidade ?? "N/A")")
                        Text("UF: \(address?.uf ?? "N/A")")
                        Text("IBGE: \(address?.ibge ?? "N/A")")
                        Text("GIA: \(address?.gia ?? "N/A")")
                        Text("DDD: \(address?.ddd ?? "N/A")")
                        Text("SIAFI: \(address?.siafi ?? "N/A")")
        }
        .task {
            do {
                self.address = try await getAddress(cep: cep)
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
    
    func getAddress(cep: String) async throws -> Address {
        let endpoint = "https://viacep.com.br/ws/\(cep)/json/"
        print("entrou1")
        ///Verifica se url está correta
        guard let url = URL(string: endpoint) else {
            throw CHError.invalidURL
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        //confere se a resposta é do tipo HTTPUELResponce e vê se o statusCode dela é 200
        guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
            throw CHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            print("entrou")
            return try decoder.decode(Address.self, from: data)
        } catch {
            throw CHError.invalidData
        }
    }
    
}

struct cepAPI_Previews: PreviewProvider {
    static var previews: some View {
        cepAPI()
    }
}
