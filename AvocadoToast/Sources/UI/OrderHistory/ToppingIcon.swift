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

    @Environment(\.colorScheme) var colorScheme

    init(_ topping: Topping) {
        self.topping = topping
    }
    
    var body: some View {
        Text(topping.abbreviation)
            .padding(8)
            .font(Font.body.bold())
            .foregroundColor(topping.forgroundColor(with: colorScheme))
            .background(Circle().fill(topping.fillColor))
    }
}

extension Topping {

    fileprivate func forgroundColor(with colorScheme: ColorScheme) -> Color {
        switch self {
        case .salt:
            return colorScheme == .light ? .white: .black
        default:
            return .white
        }
    }

    fileprivate var fillColor: Color {
        switch self {
        case .salt:
            return .primary
        case .redPepperFlakes:
            return .red
        case .egg:
            return .yellow
        }
    }
    
    var abbreviation: String {
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
            ToppingIcon(.salt)
            .environment(\.colorScheme, .dark)
            ToppingIcon(.redPepperFlakes)
            ToppingIcon(.egg)
        }
    }
}
