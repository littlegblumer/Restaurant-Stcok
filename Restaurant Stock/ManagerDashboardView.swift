//
//  ManagerDashboardView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import SwiftUI
import Foundation // ✅ Necessário para corrigir os erros!

struct ManagerDashboardView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var selectedRole: Setor = .cozinha
    @State private var showConfirmation = false
    @ObservedObject var viewModel: InventoryViewModel
    
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
            #if os(IOS)
                .keyboardType(.emailAddress) // ✅ Correção correta!
                .textInputAutocapitalization(.never) // ✅ Sem auto capitalização
            #endif
            // ✅ Telefone do Funcionário
            TextField("Phone", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                //.keyboardType(.phonePad) // ✅ Correção!
            
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
                Text("Create User")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            
            // ✅ Mensagem de Confirmação
            if showConfirmation {
                Text("✅ User created and SMS sent successfully!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }
    
    // ✅ Criação de Usuário e Envio de SMS
        func createUser(name: String, email: String, phone: String, role: Setor) {
            // Simulando envio de SMS com link para criação da senha
            let link = "https://restaurante.com/create-password?email=\(email)"
            print("📲 Sending SMS to \(phone) with link: \(link)")
            
            // ✅ Simulação de envio bem-sucedido
            showConfirmation = true
        }
    }
   
