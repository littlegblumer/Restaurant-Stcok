//
//  ManagerLoginView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import SwiftUI
import Foundation

struct ManagerLoginView: View {
    @State private var email = "manager@restaurante.com" // ✅ Email fixo
    @State private var password = ""
    @State private var showManagerDashboard = false
    @State private var loginError = false
    @ObservedObject var viewModel: InventoryViewModel // ✅ Passando o viewModel
    
    var body: some View {
        VStack {
            Text("👔 Manager Login")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            // ✅ Campo de Email (Desativado, manager fixo)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(true) // ✅ Email fixo para manager
            
            #if os(iOS)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            #endif
            
            // ✅ Campo de Senha
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // ✅ Mensagem de Erro
            if loginError {
                Text("❌ Invalid password")
                    .foregroundColor(.red)
            }
            
            // ✅ Botão de Login
            Button(action: {
                if viewModel.authenticateUser(email: email, password: password) {
                    showManagerDashboard = true
                } else {
                    loginError = true
                }
            }) {
                Text("Login")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            
            // ✅ Navegação para ManagerDashboard após login
            NavigationLink(destination: ManagerDashboardView(viewModel: viewModel), isActive: $showManagerDashboard) {
                EmptyView()
            }
        }
        .padding()
    }
}
