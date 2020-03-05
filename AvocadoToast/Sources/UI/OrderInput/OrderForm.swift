//
//  OrderForm.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct OrderForm: View {
    @State private var order: Order = Order()
    @State private var showAlert: Bool = false

    private let history: History

    init(_ history: History) {
        self.history = history
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $order.bread, label: Text("Bread")) {
                        ForEach(BreadType.allCases) { bread in
                            Text(bread.name).tag(bread)
                        }
                    }
                    Picker(selection: $order.spread, label: Text("Spread")) {
                        ForEach(Spread.allCases) { spread in
                            Text(spread.name).tag(spread)
                        }
                    }
                    Picker(selection: $order.avocado, label: Text("Avocado")) {
                        ForEach(AvocadoStyle.allCases) { style in
                            Text(style.name).tag(style)
                        }
                    }
                }
                Section {
                    Toggle(isOn: $order.includeSalt) {
                        Text("Include Salt")
                    }
                    Toggle(isOn: $order.includeRedPepper) {
                        Text("Include Red Pepper")
                    }
                    Toggle(isOn: $order.includeEgg.animation()) {
                        Text("Include Egg")
                    }
                    if order.includeEgg {
                        NavigationLink(destination: EggLocationPicker(eggLocation: $order.eggLocation)) {
                            Text("Egg Location")
                        }
                    }
                }
                Section {
                    Stepper(value: $order.quantity, in: 0...10) {
                        Text("Quantity: \(order.quantity)")
                    }
                }
                Section {
                    Button(action: {
                        self.submitOrder()
                        self.showAlert = true
                    }) {
                        Text("Order")
                    }
                    .disabled(order.quantity == 0)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Confirmation"),
                            message: Text("The order has been placed. Thank you!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
            .navigationBarTitle(Text("Avocado Toast"))
        }
    }

    func submitOrder() {
        history.add(CompleteOrder(order: order))
        withAnimation {
            order = Order()
        }
    }
}

struct OrderForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderForm(History())
            OrderForm(History())
                .environment(\.sizeCategory, .extraExtraLarge)
                .environment(\.colorScheme, .dark)
                .environment(\.locale, Locale(identifier: "en_US"))
            OrderForm(History())
                .environment(\.sizeCategory, .small)
                .environment(\.colorScheme, .light)
                .environment(\.locale, Locale(identifier: "he_IL"))
        }
    }
}
