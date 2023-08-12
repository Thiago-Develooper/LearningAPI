import Foundation

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
}

class Service {
    ///Aqui fica o corpo do endpoin, para não termos que escrevelo toda hora.
    private let baseURL = "https://viacep.com.br/ws"
    
            ///Valor da consulta    ///Retorno
    func get(cep: String, callback: @escaping (Result<Any, ServiceError>) -> Void) {
        let path = "/\(cep)/json" //path é o caminho da requisição (aparentemente é usado para cada tipo de requisição em sistemas mais complexos.
        
        
        ///Este trecho de código verifica de a url está com a formatação serta ou seja, se segue as regras que todas as urls devem seguir.
        guard let url = URL(string: baseURL + path) else {
            callback(.failure(.invalidURL))
            return
        }
        
        //Aqui não importa os nomes, data, reponse e error, mas sim a sequência deles.
        let task = URLSession.shared.dataTask(with: url) { data, response, error in //data: retorna o corpo da requisição, response: objeto de resposta, como code-responce, header, cash, informações assim, error: se tiver algum tipo de erro ele retornara.
            
            //temos que validar o data (se o data tiver retornado é porque a requisição deu certo
            guard let data = data else { //desenpacota e ver se a requisição não voltou como nil, ou seja n retornou dados).
                callback(.failure(.network(error)))
                return
            }
            
            //Se o código chegou até aqui a requisição foi recebida devemos tratar o JSON
            
            //Vamos transformar este dado em um objeto json.
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)  //fragmentos permite que a informação seja passada como um dicionary.
            callback(.success(json))
            }
            task.resume()
    }
}

do {
    let service = Service()
    service.get(cep: "01001000") { result in
        DispatchQueue.main.async {//volta para a thread principal
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                print(data)
            }
        }
    }
}
