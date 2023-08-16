import SwiftUI

// Enum para definir os níveis de dificuldade
enum Level {
    case easy
    case medium
    case hard
}

struct ContentView: View {
    
    // Estado das variáveis
    @State private var multiplicadorRandom1 = 0
    @State private var multiplicadorRandom2 = 0
    @State private var level: Level = .easy
    @State private var showPresentScreen: Bool = false
    @State private var resultado: Int = 0
    @State private var resposta: String = ""
    @State private var showResult: Bool = false // Mostrar ou ocultar o resultado
    
    var body: some View {
        VStack {
            Spacer()
            
            // Exibe a visualização dos multiplicadores
            viewMultiplicadores(num1: multiplicadorRandom1, num2: multiplicadorRandom2)
            
            // Exibe o resultado somente quando showResult for true
            if showResult {
                showResultado(resultado: resultado)
            }
                        
            // Campo de texto para entrada do usuário
            textField()
            
            // Mostra a validação da resposta
            if let intValue = Int(resposta) {
                showValidacao(intValue: intValue)
                
            } else {
                showValidacao(intValue: nil)
            }
            
            Spacer()
            Spacer()
            
            // Botões para alterar os multiplicadores e nível de dificuldade
            buttons()
            
            Spacer()
            
            // Botão para mostrar/ocultar o resultado
            toggleResultadoButton()
        }
    }
    
    // Função para atualizar os multiplicadores
    func updateMultiplicadores() {
        if level == .easy {
            multiplicadorRandom1 = Int.random(in: 1...10)
            multiplicadorRandom2 = Int.random(in: 1...10)
        } else if level == .medium {
            multiplicadorRandom1 = Int.random(in: 11...20)
            multiplicadorRandom2 = Int.random(in: 11...20)
        } else if level == .hard {
            multiplicadorRandom1 = Int.random(in: 11...30)
            multiplicadorRandom2 = Int.random(in: 11...30)
        }
        
        resultado = multiplicar(num1: multiplicadorRandom1, num2: multiplicadorRandom2)
        resposta = ""
    }
    
    // Função para calcular o resultado da multiplicação
    func multiplicar(num1: Int, num2: Int) -> Int {
        return num1 * num2
    }
    
    // Função para exibir os multiplicadores
    func viewMultiplicadores(num1: Int, num2: Int) -> some View {
        return Text("\(num1) x \(num2)")
            .font(.largeTitle)
            .padding()
    }
    
    // Função para exibir o resultado
    func showResultado(resultado: Int) -> some View {
        return Text("Resultado: \(resultado)")
            .font(.headline)
            .padding()
    }
    
    // Função para exibir o campo de texto
    func textField() -> some View {
        return TextField("Digite um número", text: $resposta)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
    }
    
    // Função para exibir a validação da resposta
    func showValidacao(intValue: Int?) -> some View {
        return RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(
                intValue == resultado ? Color(.green) : Color(.red)
            )
            .frame(width: 150, height: 50)
    }
    
    // Função para exibir os botões
    func buttons() -> some View {
        return HStack {
            Button {
                updateMultiplicadores()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(
                            Color(.systemPink)
                        )
                        .frame(width: 150, height: 50)
                    
                    Text("Create")
                        .foregroundColor(.white)
                }
            }
            
            Button {
                showPresentScreen.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(
                            Color(.black)
                        )
                        .frame(width: 150, height: 50)
                    
                    Text("Difficult")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    // Função para exibir o botão para mostrar/ocultar o resultado
    func toggleResultadoButton() -> some View {
        return Button("Mostrar Resultado") {
            showResult.toggle()
        }
        .sheet(isPresented: $showPresentScreen) {
            NewScreen(showNewScreen: $showPresentScreen, level: $level)
        }
        .foregroundColor(.gray)
    }
}

struct NewScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showNewScreen: Bool
    @Binding var level: Level
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            }

            VStack {
                Button {
                    level = .easy
                } label: {
                    Text("easy")
                }
                .padding()
                .padding(.top, 40)
                
                Button {
                    level = .medium
                } label: {
                    Text("medium")
                }
                .padding()
                
                Button {
                    level = .hard
                } label: {
                    Text("Hard")
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
