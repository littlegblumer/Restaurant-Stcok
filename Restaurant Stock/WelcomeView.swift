//
//  WelcomeView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: InventoryViewModel
    @Binding var showWelcomeView: Bool  // ✅ Adicionado para controlar exibição
    
    var body: some View {
        VStack(spacing: 20) {
            Text("👋 Welcome to Restaurant Stock!")
                .font(.largeTitle)
                .padding(.top, 50)
            
            Spacer()
            
            // ✅ Botão para Gerente
            Button(action: {
                showWelcomeView = false  // Oculta a WelcomeView
            }) {
                NavigationLink(destination: ManagerLoginView(viewModel: viewModel)) {
                    Text("👔 Manager Login")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)
            
            // ✅ Botão para Funcionário
            Button(action: {
                showWelcomeView = false  // Oculta a WelcomeView
            }) {
                NavigationLink(destination: LoginView(user: .constant(nil), viewModel: viewModel)) {
                    Text("👷 Employee Login")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
    }
}
