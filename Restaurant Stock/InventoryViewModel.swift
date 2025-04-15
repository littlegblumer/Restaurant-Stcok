//
//  InventoryViewModel.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import Foundation
import Combine

class InventoryViewModel: ObservableObject {
    @Published var items: [Item] = [
        // Produtos para a Cozinha
        Item(name: "Tomato", quantity: 5, minQuantity: 10, supplierEmail: "fornecedor@restaurante.com", setor: .cozinha),
        Item(name: "Onion", quantity: 12, minQuantity: 10, supplierEmail: "fornecedor@restaurante.com", setor: .cozinha),
        Item(name: "Cheese", quantity: 20, minQuantity: 15, supplierEmail: "fornecedor@restaurante.com", setor: .cozinha),
        Item(name: "Chicken", quantity: 8, minQuantity: 10, supplierEmail: "fornecedor@restaurante.com", setor: .cozinha),
        Item(name: "Rice", quantity: 30, minQuantity: 25, supplierEmail: "fornecedor@restaurante.com", setor: .cozinha),
        Item(name: "Olive Oil", quantity: 4, minQuantity: 5, supplierEmail: "fornecedor@restaurante.com", setor: .cozinha),

        // Produtos para o Bar
        Item(name: "Vodka", quantity: 3, minQuantity: 5, supplierEmail: "fornecedor@restaurante.com", setor: .bar),
        Item(name: "Whiskey", quantity: 2, minQuantity: 5, supplierEmail: "fornecedor@restaurante.com", setor: .bar),
        Item(name: "Gin", quantity: 6, minQuantity: 5, supplierEmail: "fornecedor@restaurante.com", setor: .bar),
        Item(name: "Lemon", quantity: 15, minQuantity: 10, supplierEmail: "fornecedor@restaurante.com", setor: .bar),
        Item(name: "Mint Leaves", quantity: 5, minQuantity: 5, supplierEmail: "fornecedor@restaurante.com", setor: .bar),
        Item(name: "Ice Cubes", quantity: 50, minQuantity: 40, supplierEmail: "fornecedor@restaurante.com", setor: .bar),
        
        // Produtos para o Garçom
        Item(name: "Napkins", quantity: 20, minQuantity: 10, supplierEmail: "fornecedor@restaurante.com", setor: .garcom),
        Item(name: "Plates", quantity: 50, minQuantity: 40, supplierEmail: "fornecedor@restaurante.com", setor: .garcom),
        Item(name: "Glasses", quantity: 30, minQuantity: 20, supplierEmail: "fornecedor@restaurante.com", setor: .garcom),
        Item(name: "Cutlery", quantity: 40, minQuantity: 30, supplierEmail: "fornecedor@restaurante.com", setor: .garcom),
        Item(name: "Straws", quantity: 100, minQuantity: 80, supplierEmail: "fornecedor@restaurante.com", setor: .garcom),
        Item(name: "Serving Trays", quantity: 15, minQuantity: 10, supplierEmail: "fornecedor@restaurante.com", setor: .garcom)
    ]
    
    @Published var currentUser: User?  // Armazena o usuário logado
    @Published var users: [User] = [] // ✅ Lista de usuários
    @Published var alerts: [String] = []
    @Published var scannedResult: String = ""  // ✅ Armazena o resultado do QR Code

    // ✅ Filtra os itens pelo setor do usuário logado
    var filteredItems: [Item] {
        guard let setor = currentUser?.setor else { return [] }
        return items.filter { $0.setor == setor }
    }

    // ✅ Função para realizar o login e verificar estoque
    func login(user: User) {
        currentUser = user
        checkStock() // Verifica o estoque logo após o login
    }

    // ✅ Verifica os itens abaixo do mínimo e gera alertas
    func checkStock() {
        alerts.removeAll() // Limpa os alertas anteriores
        for item in filteredItems {
            if item.quantity < item.minQuantity {
                let alertMessage = "⚠️ Alert: \(item.name) is below the minimum quantity! Contact \(item.supplierEmail)."
                alerts.append(alertMessage)
            }
        }
    }
    // ✅ Manager preexistente com login fixo
        let managerUser = User(name: "Manager", setor: .cozinha, password: "123456")
        
        init() {
            // ✅ Adiciona o Manager ao sistema
            users.append(managerUser)
        }

        // ✅ Login do Manager e Funcionários
        func authenticateUser(email: String, password: String) -> Bool {
            if email == "manager@restaurante.com" && password == "123456" {
                currentUser = managerUser
                return true
            }
            
            // Verifica se é um funcionário
            if let foundUser = users.first(where: { $0.name.lowercased() == email.lowercased() && $0.password == password }) {
                currentUser = foundUser
                return true
            }
            
            return false
        }

    // ✅ Função para adicionar um novo usuário
    func addUser(_ user: User) {
        users.append(user)
        print("✅ User added: \(user.name), Sector: \(user.setor.rawValue)")
    }

    // ✅ Alerta de reposição para fornecedores
    func sendRestockAlert(for item: Item) {
        print("⚠️ Alert: \(item.name) is below the minimum quantity! Contact \(item.supplierEmail).")
    }

    // ✅ Remove uma quantidade específica do item
    func removeItem(_ item: Item, amount: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity -= amount
            checkStock()
        }
    }

    // ✅ Função para atualizar o inventário após escanear o QR Code
    func updateInventoryFromQR(_ scannedCode: String) {
        if let index = items.firstIndex(where: { $0.name.lowercased() == scannedCode.lowercased() }) {
            items[index].quantity += 1  // ✅ Incrementa a quantidade do item escaneado
            scannedResult = "✅ \(items[index].name) Restocked: \(items[index].quantity) units"
            
            // ✅ Notifica os funcionários que o item foi reabastecido
            alerts.append("✅ \(items[index].name) has been restocked by the supplier!")
            
            // ✅ Verifica novamente o estoque para remover alertas de itens em falta
            checkStock()
        } else {
            scannedResult = "❌ Product not found"
        }
        // ✅ Verifica se o gerente tem permissão para acessar
        func authenticateUser(email: String, password: String) -> Bool {
            if email == "manager@restaurante.com" && password == "123456" {
                return true // ✅ Login autorizado
            } else {
                return false // ❌ Falha no login
            }
        }

    }
}
