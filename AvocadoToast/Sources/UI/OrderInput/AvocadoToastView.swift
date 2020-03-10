//
//  AvocadoToastView.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 09/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct AvocadoToastView: View {
    @Binding var order: CompleteOrder
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    var body: some View {
        ZStack {
            Image("Toast")
                .resizable()
                .aspectRatio(contentMode: .fit)
            if order.toppings.contains(.egg) {
                EggPlacementView(eggPlacement: $order.eggLocation)
            }
        }
        .aspectRatio(contentMode: .fit)
        .saturation(isEnabled ? 1.0 : 0.2)
    }
}

struct AvocadoToastView_Previews: PreviewProvider {
    static var previews: some View {
        AvocadoToastView(order: .constant(History().orders.first!))
    }
}
