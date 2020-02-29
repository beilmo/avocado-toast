//
//  Spread.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

/// The type of spread to be applied ove the bread.
enum Spread: CaseIterable, Hashable, Identifiable {
    case none
    case almondButter
    case peanutButter
    case honey
    case almou
    case tapenade
    case hummus
    case mayonnaise
    case kyopolou
    case adjvar
    case pindjur
    case vegemite
    case chutney
    case cannedCheese
    case feroce
    case kartoffelkase
    case tartarSauce
}

extension Spread {

    var id: Int { hashValue }

    var name: String {
        switch self {

        case .none:
            return "None"

        case .almondButter:
            return "Almond Butter"

        case .peanutButter:
            return "Peanut Butter"

        case .honey:
            return "Honey"

        case .almou:
            return "Almou"

        case .tapenade:
            return "Tapenade"

        case .hummus:
            return "Hummus"

        case .mayonnaise:
            return "Mayonnaise"

        case .kyopolou:
            return "Kyopolou"

        case .adjvar:
            return "Adjvar"

        case .pindjur:
            return "Pindjur"

        case .vegemite:
            return "Vegemite"

        case .chutney:
            return "Chutney"

        case .cannedCheese:
            return "Cheese Spray"

        case .feroce:
            return "Féroce"

        case .kartoffelkase:
            return "Kartoffelkäse"

        case .tartarSauce:
            return "Tartar Sauce"
        }
    }
}
