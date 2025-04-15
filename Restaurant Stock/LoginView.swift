//
//  LoginView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import SwiftUI

struct LoginView: View {
    @State private var selectedSetor: Setor = .cozinha
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToInventory = false // ✅ Controla a navegação após login
    
    
    @Binding var user: User? // ✅ O usuário é passado por referência
    
    @ObservedObject var viewModel: InventoryViewModel // ✅ Usando o viewModel
    
    private let authService = AuthService()
    
    var body: some View {
        VStack {
            Text("Login").font(.largeTitle).bold()
            
            // ✅ Campo de Nome
            TextField("Your Name", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // ✅ Campo de Senha
            SecureField("Password", text: $password)  // ✅ Campo de senha
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // ✅ Picker para o Setor
            Picker("Sector", selection: $selectedSetor) {
                ForEach(Setor.allCases, id: \.self) { setor in
                    Text(setor.rawValue).tag(setor)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // ✅ Botão de Login
            Button("Sign in") {
                authenticateUser()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Authentication Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        // ✅ Navigation after login success
        .navigationDestination(isPresented: $navigateToInventory) {
            InventoryView(viewModel: viewModel)}
    }

    // ✅ Função de autenticação
        private func authenticateUser() {
            // Tenta autenticar com o serviço
            if authService.authenticate(setor: selectedSetor, password: password) {
                // Se autenticado, cria o usuário e o atribui ao viewModel
                let authenticatedUser = User(name: userName, setor: selectedSetor, password: password)
                user = authenticatedUser // Atribuindo ao Binding de User
                viewModel.currentUser = authenticatedUser // Atualiza o usuário no viewModel
                
                // ✅ Ativa a navegação para InventoryView
                navigateToInventory = true
            } else {
                alertMessage = "Invalid password for \(selectedSetor.rawValue). Try again!"
                showAlert = true
            }
        }
    }
