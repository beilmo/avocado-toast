//
//  EggPlacementView.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct EggPlacementView: View {
    @Binding var eggPlacement: UnitPoint
    @GestureState private var translation: CGSize = .zero
    @Environment(\.isEnabled) private var isEnabled: Bool

    var body: some View {
        ZStack {
            Image("Toast")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image("Egg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .position(eggPosition)
                .gesture(dragGesture)
        }
        .aspectRatio(contentMode: .fit)
        .saturation(isEnabled ? 1.0 : 0.2)
    }

    private var dragGesture: some Gesture {
        return DragGesture()
            .updating($translation, body: { (value, state, transaction) in
                state = value.translation
            })
            .onEnded { value in
                self.eggPlacement.x += value.translation.width / 375
                self.eggPlacement.y += value.translation.height / 375
        }
    }

    private var eggPosition: CGPoint {
        return CGPoint(x: eggPlacement.x * 375 + translation.width,
                       y: eggPlacement.y * 375 + translation.height)
    }
}

struct EggPlacementView_Previews: PreviewProvider {
    static var previews: some View {
        EggPlacementView(eggPlacement: .constant(.center))
    }
}
