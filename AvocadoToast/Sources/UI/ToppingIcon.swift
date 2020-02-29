//
//  ToppingIcon.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct ToppingIcon: View {
    let topping: Topping

    init(_ topping: Topping) {
        self.topping = topping
    }

    var body: some View {
        Text(topping.abbreviation)
            .padding(8)
            .font(Font.body.bold())
            .foregroundColor(.white)
            .background(Circle().fill(topping.color))
    }
}

extension Topping {
    fileprivate var color: Color {
        switch self {
        case .salt:
            return .black
        case .redPepperFlakes:
            return .red
        case .egg:
            return .yellow
        }
    }

    fileprivate var abbreviation: String {
        switch self {
        case .salt:
            return "S"
        case .redPepperFlakes:
            return "R"
        case .egg:
            return "E"
        }
    }
}

struct ToppingIcon_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ToppingIcon(.salt)
            ToppingIcon(.redPepperFlakes)
            ToppingIcon(.egg)
        }
    }
}
