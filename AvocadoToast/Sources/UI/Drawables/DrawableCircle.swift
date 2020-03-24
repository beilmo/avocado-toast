//
//  DrawableCircle.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 12/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class DrawableCircle {
    var paperSize: PaperSize
    var rect: CGRect!
    var size: CGFloat!

    let context: UIGraphicsPDFRendererContext

    init(paperSize: PaperSize, context: UIGraphicsPDFRendererContext) {
        self.paperSize = paperSize
        self.context = context
    }

    init(paperSize: PaperSize, context: UIGraphicsPDFRendererContext, size: CGFloat) {
        self.paperSize = paperSize
        self.context = context
        self.size = size
    }

    init(rect: CGRect, paperSize: PaperSize, context: UIGraphicsPDFRendererContext, size: CGFloat) {
        self.rect = rect
        self.paperSize = paperSize
        self.context = context
        self.size = size
    }
}

extension DrawableCircle {

    func draw(color: UIColor) {
        guard let lastElementRect = Coordinator.shared.elementsEdges.last else {
            preconditionFailure("Error in getting last coords")
        }

        if size == nil {
            size = lastElementRect.bottom - lastElementRect.top
        }

        rect = CGRect(
            x: lastElementRect.trailing,
            y: lastElementRect.top,
            width: size,
            height: size)

        let circleCGPath = Circle().path(in: CGRect(x: 0, y: 0, width: size, height: size))

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))

        let circleImage = renderer.image { (context) in
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.addPath(circleCGPath.cgPath)
            context.cgContext.drawPath(using: .fill)
        }

        let leading = rect.origin.x // x coord
        let trailing = rect.origin.x + rect.size.width // width
        let bottom = rect.origin.y + rect.size.height // height
        let top = rect.origin.y // y coord

        let edgeInsets = EdgeInsets(leading: leading,
                                    trailing: trailing,
                                    bottom: bottom,
                                    top: top)

        Coordinator.shared.addElementEdges(edgeInsets)
        Coordinator.shared.addElementRect(rect)
        Coordinator.shared.draw(element: circleImage)
    }

    func addInnerText(string: String, font: CGFloat, alignment: Alignment, color: UIColor) {
        DrawableText(paperSize: paperSize, context: context).drawInner(string: string, font: font, alignment: alignment, in: rect, color: color)
    }
}
