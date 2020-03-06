//
//  LocalOrderProcessor.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 06/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

struct LocalOrderProcessor: OrderProcessor {
    let history: History

    func process(_ order: Order) {
        history.add(CompleteOrder(order: order))
    }
}
