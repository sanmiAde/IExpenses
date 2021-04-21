//
//  AddView.swift
//  iExpense
//
//  Created by sanmi_personal on 20/04/2021.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expense : Expenses
    @State  private var name = ""
    @State  private var type = "Personal"
    @State  private var amount = ""
    @State private var isAmountNotValid = false
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }.alert(isPresented: $isAmountNotValid, content: {
                Alert(title: Text("Invalid amount"), message: Text("Please input a valid amount"), dismissButton: .default(Text("Okay")))

            })
            .navigationBarTitle("Add expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: self.amount)
                    self.expense.items.append(item)
                } else {
                    isAmountNotValid = true
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expense: Expenses())
    }
}
