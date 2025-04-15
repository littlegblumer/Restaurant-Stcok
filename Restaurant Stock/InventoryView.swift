//
//  InventoryView.swift
//  Restaurant Stock
//
//  Created by Guilherme Martins de Carvalho Blumer on 3/13/25.
//

import SwiftUI


struct InventoryView: View {
    @ObservedObject var viewModel: InventoryViewModel

    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.currentUser {
                    // ✅ Verifica itens em falta e exibe alertas
                    let itemsInShortage = viewModel.items.filter {
                        $0.quantity < $0.minQuantity && $0.setor == user.setor
                    }

                    if !itemsInShortage.isEmpty {
                        // ✅ Lista de alertas para itens abaixo do estoque
                        List(itemsInShortage) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("⚠️ \(item.name) is below the minimum quantity!")
                                        .foregroundColor(.red)
                                        .font(.headline)
                                }
                                Spacer()

                                // ✅ Botão para contatar fornecedor diretamente dos alertas
                                Button(action: {
                                    sendEmail(to: item.supplierEmail, subject: "Restock Request", body: "Dear Supplier,\n\nWe need to restock the following item: \(item.name)\n\nPlease confirm delivery as soon as possible.\n\nThank you!")
                                }) {
                                    Text("Contact Supplier")
                                        .padding(8)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    } else {
                        // ✅ Caso não haja itens abaixo do estoque
                        Text("✅ No items are below the minimum quantity.")
                            .padding()
                            .font(.title2)
                            .foregroundColor(.green)
                    }

                    // ✅ Lista de itens filtrados pelo setor do usuário logado
                    List(viewModel.filteredItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)

                                if item.quantity < item.minQuantity {
                                    Text("⚠️ Low stock!")
                                        .foregroundColor(.red)
                                        .font(.subheadline)
                                }
                            }
                            Spacer()

                            Text("\(item.quantity)")
                                .foregroundColor(item.quantity < item.minQuantity ? .red : .primary)
                                .font(.subheadline)

                            Text("in stock")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            // ✅ Botão para contatar fornecedor diretamente dos itens com baixo estoque
                            if item.quantity < item.minQuantity {
                                Button(action: {
                                    sendEmail(to: item.supplierEmail, subject: "Restock Request", body: "Dear Supplier,\n\nWe need to restock the following item: \(item.name)\n\nPlease confirm delivery as soon as possible.\n\nThank you!")
                                }) {
                                    Text("Contact Supplier")
                                        .padding(8)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                } else {
                    // ✅ Mensagem de erro se o usuário não estiver logado
                    Text("Error: No user logged in!")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Inventory")
        }
    }

    // ✅ Envia e-mail para o fornecedor
    func sendEmail(to email: String, subject: String, body: String) {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let mailtoURL = "mailto:\(email)?subject=\(subjectEncoded)&body=\(bodyEncoded)"
        
        #if os(iOS)
        if let url = URL(string: mailtoURL), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("❌ Unable to send email!")
        }
        #else
        print("📧 Email link: \(mailtoURL)")  // Para macOS, apenas imprime o link
        #endif
    }
}
