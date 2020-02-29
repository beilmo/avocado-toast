//
//  EggLocationPicker.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct EggLocationPicker: View {
    @Binding var eggLocation: UnitPoint

    var body: some View {
        EggPlacementView(eggPlacement: $eggLocation)
            .navigationBarTitle("Egg Location", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: resetToCenter){
                    Text("Reset")
                }.disabled(eggLocation == .center))
    }

    private func resetToCenter() {
        withAnimation(.spring()) {
            eggLocation = .center
        }
    }
}

struct EggLocationPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EggLocationPicker(eggLocation: .constant(.center))
        }
    }
}
