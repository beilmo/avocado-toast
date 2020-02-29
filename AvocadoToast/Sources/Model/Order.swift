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
    var bread: BreadType = .wheat
    var avocado: AvocadoStyle = .sliced
    var spread: Spread = .none
    
    var includeSalt: Bool = true
    var includeRedPepper: Bool = false
    var includeEgg: Bool = false

    var eggLocation: UnitPoint = .center

    var quantity: Int = 0
}
