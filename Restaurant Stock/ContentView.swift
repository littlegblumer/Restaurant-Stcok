//
//  ContentView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = InventoryViewModel()
    @State private var showLoginView = true  // ✅ Controla se o login será exibido
    @State private var showWelcomeView = true  // ✅ Controla se a tela de Welcome será exibida
    
    var body: some View {
        NavigationStack {
            VStack {
                if showWelcomeView {
                    // ✅ Exibe a tela de boas-vindas antes de qualquer login
                    WelcomeView(viewModel: viewModel, showWelcomeView: $showWelcomeView)
                } else if viewModel.currentUser != nil {
                    // ✅ Se o usuário estiver logado, mostra o InventoryView com botão de retorno
                    InventoryView(viewModel: viewModel)
                        .navigationBarBackButtonHidden(true) // Esconde a seta padrão
                } else {
                    // ✅ Tela de login para os setores (Bar, Cozinha, Garçom)
                    LoginView(user: $viewModel.currentUser, viewModel: viewModel)
                        .onReceive(viewModel.$currentUser) { newValue in
                            if newValue != nil {
                                showLoginView = false
                            }
                        }
                }
            }
            .navigationTitle(getNavigationTitle())
            .toolbar {
                if viewModel.currentUser != nil {
#if os(iOS)
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            // 🔙 Retorna para a tela de login
                            viewModel.currentUser = nil
                            showLoginView = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Logout")
                            }
                            .foregroundColor(.blue)
                        }
                    }
#else
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            // 🔙 Retorna para a tela de login
                            viewModel.currentUser = nil
                            showLoginView = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Logout")
                            }
                            .foregroundColor(.blue)
                        }
                    }
#endif
                }
            }
        }
    }
    
    // ✅ Define o título dinamicamente
    func getNavigationTitle() -> String {
        if showWelcomeView {
            return "Welcome"
        } else if viewModel.currentUser == nil {
            return "Login"
        } else {
            return "Inventory"
        }
    }
}
