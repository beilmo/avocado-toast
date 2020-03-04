//
//  CompleteOrder.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

struct CompleteOrder: Identifiable {
    let bread: BreadType
    let spread: Spread
    let avocado: AvocadoStyle
    let toppings: [Topping]
    let quantity: Int
    let timeStamp: Date
    let id = UUID()
}

extension CompleteOrder {
    init(order: Order) {
        bread = order.bread
        spread = order.spread
        avocado = order.avocado
        toppings = order.toppings
        quantity = order.quantity
        timeStamp = Date()
    }
}
