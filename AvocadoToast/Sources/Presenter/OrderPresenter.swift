//
//  CompleteOrderPresenter.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 04/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

struct OrderPresenter {
    let order: CompleteOrder
}

extension OrderPresenter: Identifiable {
    var id: UUID {
        order.id
    }
}

fileprivate let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

extension OrderPresenter {
    var toppings: [Topping] {
        order.toppings
    }

    var purchaseDate: String {
        dateFormatter.string(from: order.timeStamp)
    }

    var summary: String {
        switch order.spread {
        case .none:
            return order.bread.name
        default:
            return "\(order.bread.name) with \(order.spread.name)"
        }
    }
}
