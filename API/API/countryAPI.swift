//
//  countryAPI.swift
//  API
//
//  Created by Thiago Pereira de Menezes on 14/08/23.
//

import SwiftUI

//struct Country: Codable {
//    let region: String
//}

struct Country: Codable {
    struct Name: Codable {
        let common: String?
        let official: String?
        struct NativeName: Codable {
            let por: NativeNameValue?
        }
        let nativeName: NativeName?
    }
    struct NativeNameValue: Codable {
        let official: String?
        let common: String?
    }
    let name: Name?
    let tld: [String]?
    let cca2: String?
    let ccn3: String?
    let cca3: String?
    let cioc: String?
    let independent: Bool?
    let status: String?
    let unMember: Bool?
    struct Currency: Codable {
        let name: String?
        let symbol: String?
    }
    let currencies: [String: Currency]?
    struct Idd: Codable {
        let root: String?
        let suffixes: [String]?
    }
    let idd: Idd?
    let capital: [String]?
    let altSpellings: [String]?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    struct Translations: Codable {
        let ara: Translation?
        let bre: Translation?
        // Adicione outras traduções aqui...
    }
    struct Translation: Codable {
        let official: String?
        let common: String?
    }
    let translations: Translations?
    let latlng: [Double]?
    let landlocked: Bool?
    let borders: [String]?
    let area: Double?
    struct Demonyms: Codable {
        let eng: Demonym?
        let fra: Demonym?
    }
    struct Demonym: Codable {
        let f: String?
        let m: String?
    }
    let demonyms: Demonyms?
    let flag: String?
    struct Maps: Codable {
        let googleMaps: String?
        let openStreetMaps: String?
    }
    let fifa: String?
    struct Car: Codable {
        let signs: [String]?
        let side: String?
    }
    let car: Car?
    let timezones: [String]?
    let continents: [String]?
    struct Flags: Codable {
        let png: String?
        let svg: String?
        let alt: String?
    }
    let flags: Flags?
    struct CoatOfArms: Codable {
        let png: String?
        let svg: String?
    }
    let coatOfArms: CoatOfArms?
    let startOfWeek: String?
    struct CapitalInfo: Codable {
        let latlng: [Double]?
    }
    let capitalInfo: CapitalInfo?
    struct PostalCode: Codable {
        let format: String?
        let regex: String?
    }
    let postalCode: PostalCode?
}

struct countryAPI: View {
    
    @State private var country:Country?
    @State private var name:String = "brazil"
    
    var body: some View {
        VStack {
//            Text("area: \(country?.area.map { String($0) } ?? "Desconhecido")")
            Text(country?.region ?? "nfoi")
        }
        .task {
            do {
                country = try await getCountry(name: name)
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
    
    func getCountry(name: String) async throws -> Country {
        let endpoint = "https://restcountries.com/v3.1/name/\(name)"
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
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            print("entrou")
            return try decoder.decode(Country.self, from: data)
        } catch {
            throw CHError.invalidData
        }
    }
    
}


struct countryAPI_Previews: PreviewProvider {
    static var previews: some View {
        countryAPI()
    }
}
