//
//  AuthService.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/18/25.
//

import Foundation

class AuthService {
    // Senhas predefinidas para cada setor
    private let credentials: [Setor: String] = [
        .cozinha: "senha123",
        .bar: "bebidas456",
        .garcom: "mesa789"
    ]
    
    // Função para validar a senha
    func authenticate(setor: Setor, password: String) -> Bool {
        return credentials[setor] == password
    }
}
