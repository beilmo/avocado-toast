//
//  OrderHistory.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct OrderHistory: View {
    let previousOrders: [CompletedOrder]

    var body: some View {
        List(previousOrders) { order in
            OrderCell(order: order)
        }
    }
}

struct OrderHistory_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistory(previousOrders: CompletedOrder.samples)
    }
}



struct OrderCell: View {
    var order: CompletedOrder

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.summary)
                Text(order.purchaseDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            ForEach(order.toppings) { topping in
                ToppingIcon(topping)
            }
        }
    }
}
