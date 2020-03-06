//
//  Order.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import SwiftUI

struct Order {
    var bread: BreadType
    var spread: Spread
    var avocado: AvocadoStyle
    
    var includeSalt: Bool
    var includeRedPepper: Bool
    var includeEgg: Bool

    var eggLocation: UnitPoint
    var quantity: Int

    static let `default` = Self(bread: .wheat, spread: .none, avocado: .sliced, includeSalt: true, includeRedPepper: false, includeEgg: false, eggLocation: .center, quantity: 0)
}

extension Order {
    var toppings: [Topping] {
        var toppings = [Topping]()
        if includeSalt {
            toppings.append(.salt)
        }
        if includeRedPepper {
            toppings.append(.redPepperFlakes)
        }
        if includeEgg {
            toppings.append(.egg)
        }
        return toppings
    }
}
