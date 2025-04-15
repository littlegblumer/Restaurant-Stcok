//
//  SupplierView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/20/25.
//

//
//  SupplierView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/20/25.
//

import SwiftUI

struct SupplierView: View {
    @ObservedObject var viewModel: InventoryViewModel
    
    @State private var updatedQuantities: [UUID: Int] = [:]  // Armazena a atualização de cada item

    var body: some View {
        NavigationView {
            VStack {
                Text("Supplier Stock Update")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                List(viewModel.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("Current Stock: \(item.quantity)")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        TextField("New Qty", value: $updatedQuantities[item.id], format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 80)
                    }
                }

                Button("Confirm Restock") {
                    updateStock()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }

    // ✅ Atualiza o estoque e envia notificação aos setores
    private func updateStock() {
        for (id, newQty) in updatedQuantities {
            if let index = viewModel.items.firstIndex(where: { $0.id == id }) {
                viewModel.items[index].quantity += newQty
                notifyRestock(item: viewModel.items[index])
            }
        }
        updatedQuantities.removeAll()
    }

    private func notifyRestock(item: Item) {
        let message = "✅ \(item.name) has been restocked by the supplier!"
        viewModel.alerts.append(message)
    }
}
