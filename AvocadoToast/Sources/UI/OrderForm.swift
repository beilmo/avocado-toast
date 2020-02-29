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

    var body: some View {
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
                Button(action: submitOrder) { Text("Order") }
                    .disabled(order.quantity == 0)
            }
        }
        .navigationBarTitle(Text("Avocado Toast"))
    }

    func submitOrder() {
        print(order)
    }
}

struct OrderForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderForm()
            OrderForm()
                .environment(\.sizeCategory, .extraExtraLarge)
                .environment(\.colorScheme, .dark)
                .environment(\.locale, Locale(identifier: "en_US"))
            OrderForm()
                .environment(\.sizeCategory, .small)
                .environment(\.colorScheme, .light)
                .environment(\.locale, Locale(identifier: "he_IL"))
        }
    }
}
