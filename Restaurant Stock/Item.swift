//
//  Item.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import SwiftUI
import Combine



struct Item: Identifiable, Codable {
    var id = UUID()
    var name: String
    var quantity: Int
    var minQuantity: Int
    var supplierEmail: String
    var setor: Setor // sector for the item itself
}
