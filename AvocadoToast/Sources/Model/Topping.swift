//
//  Topping.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

/// Topping to be applied over the avocado.
enum Topping: CaseIterable, Hashable, Identifiable {

    /// The Salt topping is required.
    case salt

    /// The Red Pepper Flakes topping is required.
    case redPepperFlakes

    /// The Egg topping is required.
    case egg
}

extension Topping {
    
    var id: Int { hashValue }
}
