//
//  BreadType.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

/// The type of bread to be used as foundation for the avocado toast.
enum BreadType: CaseIterable, Hashable, Identifiable {
    case wheat
    case rye
    case multiGrain
    case sourdough
}

extension BreadType {

    var id: Int { hashValue }

    var name: String {
        switch self {

        case .wheat:
            return "Wheat"

        case .rye:
            return "Rye"

        case .multiGrain:
            return "Multi-Grain"

        case .sourdough:
            return "Sourdough"
        }
    }
}
