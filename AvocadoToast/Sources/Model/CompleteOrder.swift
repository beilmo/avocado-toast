//
//  CompleteOrder.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

struct CompletedOrder: Identifiable {
    let id: UUID
    let summary: String
    let purchaseDate: String
    let toppings: [Topping]
    let quantity: Int
}

#if DEBUG
extension CompletedOrder {
    static let samples: [CompletedOrder] = {
        return [
            CompletedOrder(id: UUID(),
                           summary: "Rye with Almond Butter",
                           purchaseDate: "5/30/19, 7:25 PM",
                           toppings: [.salt, .redPepperFlakes],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Multi-Grain with Hummus",
                           purchaseDate: "5/29/19, 3:39 PM",
                           toppings: [.redPepperFlakes],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Multi-Grain Toast",
                           purchaseDate: "5/28/19, 11:52 AM",
                           toppings: [.salt],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Sourdough with Chutney",
                           purchaseDate: "5/27/19, 8:05 AM",
                           toppings: [.salt, .redPepperFlakes],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Rye with Peanut Butter",
                           purchaseDate: "5/26/19, 4:19 AM",
                           toppings: [.salt, .redPepperFlakes, .egg],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Weath with Tapenade",
                           purchaseDate: "5/25/19, 12:32 AM",
                           toppings: [.egg],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Sourdough with Vegemite",
                           purchaseDate: "5/23/19, 8:45 PM",
                           toppings: [.salt],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Wheat with Féroce",
                           purchaseDate: "5/22/19, 4:59 PM",
                           toppings: [.salt, .redPepperFlakes, .egg],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Rye with Honey",
                           purchaseDate: "5/21/19, 1:12 PM",
                           toppings: [],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Multi-Grain Toast",
                           purchaseDate: "5/21/19, 9:25 AM",
                           toppings: [.salt, .egg],
                           quantity: 1),
            CompletedOrder(id: UUID(),
                           summary: "Sourdough with Chutney",
                           purchaseDate: "5/19/19, 5:39 AM",
                           toppings: [],
                           quantity: 1)

        ]
    }()
}
#endif
