//
//  AvocadoStyle.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

/// The type of avocado preparation.
enum AvocadoStyle: CaseIterable, Hashable, Identifiable {

    /// Longitudinally sliced pieces of avocado.
    case sliced

    /// Mashed avocado puree.
    case mashed
}

extension AvocadoStyle {

    var id: Int { return hashValue }

    var name: String {
        switch self {

        case .sliced:
            return "Sliced"

        case .mashed:
            return "Mashed"
        }
    }
}
