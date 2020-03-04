//
//  History.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 04/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

class History: ObservableObject {
    @Published private(set) var orders: [CompleteOrder]

    init() {
        orders = .defaultValues
    }

    func add(_ order: CompleteOrder) {
        orders.insert(order, at: 0)
    }

    func remove(at indexSet: IndexSet) {
        if let index = indexSet.first {
            orders.remove(at: index)
        }
    }

    func clear() {
        orders.removeAll()
    }
}

extension Array where Element == CompleteOrder {
    static let defaultValues: [CompleteOrder] = {
        return [
            CompleteOrder(bread: .rye,
                          spread: .almondButter,
                          avocado: .mashed,
                          toppings: [.salt, .redPepperFlakes],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1559033520)),
            CompleteOrder(bread: .multiGrain,
                          spread: .hummus,
                          avocado: .sliced,
                          toppings: [.redPepperFlakes],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1559133540)),
            CompleteOrder(bread: .multiGrainToast,
                          spread: .none,
                          avocado: .sliced,
                          toppings: [.salt],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1559033520)),
            CompleteOrder(bread: .sourdough,
                          spread: .chutney,
                          avocado: .mashed,
                          toppings: [.salt, .redPepperFlakes],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1558933500)),
            CompleteOrder(bread: .rye,
                          spread: .peanutButter,
                          avocado: .sliced,
                          toppings: [.salt, .redPepperFlakes, .egg],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1558833540)),
            CompleteOrder(bread: .wheat,
                          spread: .tapenade,
                          avocado: .sliced,
                          toppings: [.egg],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1558733520)),
            CompleteOrder(bread: .sourdough,
                          spread: .vegemite,
                          avocado: .sliced,
                          toppings: [.salt],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1558633500)),
            CompleteOrder(bread: .wheat,
                          spread: .feroce,
                          avocado: .sliced,
                          toppings: [.salt, .redPepperFlakes, .egg],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1558533540)),
            CompleteOrder(bread: .rye,
                          spread: .honey,
                          avocado: .sliced,
                          toppings: [],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1558433520)),
            CompleteOrder(bread: .multiGrainToast,
                          spread: .none,
                          avocado: .sliced,
                          toppings: [.salt, .egg],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1558419900)),
            CompleteOrder(bread: .sourdough,
                          spread: .chutney,
                          avocado: .sliced,
                          toppings: [],
                          quantity: 1,
                          timeStamp: Date(timeIntervalSince1970: 1558233540))

        ]
    }()
}
