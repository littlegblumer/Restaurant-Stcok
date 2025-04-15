//
//  User.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import Foundation

enum Setor: String, Codable, CaseIterable {
    case cozinha = "Kitchen"
    case bar = "Bar"
    case garcom = "Waitress"
}

struct User: Identifiable, Codable {
    var id = UUID()
    var name: String
    var setor: Setor
    var password: String
    
    // ✅ Método para comparar dois usuários
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
                lhs.name == rhs.name &&
                lhs.setor == rhs.setor &&
                lhs.password == rhs.password
    }
}
