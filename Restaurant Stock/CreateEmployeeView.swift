//
//  CreateEmployeeView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import SwiftUI

struct CreateEmployeeView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var selectedRole: Setor = .cozinha
    @State private var showConfirmation = false
    
    @ObservedObject var viewModel: InventoryViewModel // ✅ ViewModel herdado
    
    var body: some View {
        VStack {
            Text("📋 Create New Employee")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            // ✅ Nome do Funcionário
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // ✅ Email do Funcionário
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
#if os(iOS)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
#endif
            
            // ✅ Telefone do Funcionário
            TextField("Phone", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            #if os(iOS)
                .keyboardType(.phonePad)
            #endif
            
            // ✅ Picker para Escolher o Setor
            Picker("Role", selection: $selectedRole) {
                Text("Kitchen").tag(Setor.cozinha)
                Text("Bar").tag(Setor.bar)
                Text("Waitress").tag(Setor.garcom)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // ✅ Botão para Criar Usuário
            Button(action: {
                createUser(name: name, email: email, phone: phone, role: selectedRole)
            }) {
                Text("Create Employee")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            
            // ✅ Mensagem de Confirmação
            if showConfirmation {
                Text("✅ User created successfully!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }
    
    // ✅ Função para Criar o Usuário
    func createUser(name: String, email: String, phone: String, role: Setor) {
        let newUser = User(name: name, setor: role, password: "default123")
        viewModel.addUser(newUser) // ✅ Adiciona o usuário ao sistema
        showConfirmation = true
    }
}
