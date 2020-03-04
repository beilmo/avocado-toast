//
//  OrderRow.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 04/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct OrderRow: View {
    let presenter: OrderPresenter

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(presenter.summary)
                Text(presenter.purchaseDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            ForEach(presenter.toppings) { topping in
                ToppingIcon(topping)
            }
        }
    }
}
