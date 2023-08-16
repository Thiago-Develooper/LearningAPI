//
//  Perfil.swift
//  LearnGitHubAPI
//
//  Created by Thiago Pereira de Menezes on 16/08/23.
//

import SwiftUI

struct Perfil: View {
    
    @State var user: GitHubUser?
    
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
                        
            Spacer()
        }
    }
}

struct Perfil_Previews: PreviewProvider {
    static var previews: some View {
        Perfil()
    }
}
