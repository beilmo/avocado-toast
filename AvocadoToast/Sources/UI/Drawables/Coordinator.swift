//
//  Coordinator.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 19/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    var elementsEdges: [EdgeInsets]
    var elementsRect: [CGRect]

    init(elementsCoord: [EdgeInsets], elementsRect: [CGRect]) {
        self.elementsEdges = elementsCoord
        self.elementsRect = elementsRect
    }

    static var shared = Coordinator(elementsCoord: [], elementsRect: [])

    func addElementEdges(_ edges: EdgeInsets) {
        elementsEdges.append(edges)
    }

    func addElementRect(_ rect: CGRect) {
        elementsRect.append(rect)
    }

    func draw(element: NSAttributedString) {
        element.draw(in: elementsRect.last!)
    }

    func draw(element: UIImage) {
        element.draw(in: elementsRect.last!)
    }

    func clearCache() {
        elementsEdges.removeAll()
        elementsRect.removeAll()
    }
}
