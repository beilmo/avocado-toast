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
    let rect: CGRect

    private var offsetX: CGFloat = 0
    private var offsetY: CGFloat = 0
    private var color: UIColor = .red

    init(rect: CGRect) {
        self.rect = rect
    }

    func draw() -> CGFloat {
        let circleCGPath = Circle().path(in: rect)
        let circleRect = circleCGPath.cgPath.boundingBox

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))

        let image = renderer.image { (context) in
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.addPath(circleCGPath.cgPath)
            context.cgContext.drawPath(using: .fill)
        }

        image.draw(in: CGRect(x: 0, y: 0, width: 200, height: 200))

        return circleRect.origin.y + circleRect.size.height
    }

    func draw(offsetX: CGFloat, offsetY: CGFloat) -> EdgeInsets {
        let circleCGPath = Circle().path(in: rect)
        let circleRect = circleCGPath.cgPath.boundingBox

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: circleRect.width, height: circleRect.height))

        let image = renderer.image { (context) in
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.addPath(circleCGPath.cgPath)
            context.cgContext.drawPath(using: .fill)
        }

        self.offsetX = offsetX
        self.offsetY = offsetY

        let newCircleRect = CGRect(x: offsetX, y: offsetY, width: circleRect.width, height: circleRect.height)

        image.draw(in: newCircleRect)

        let leading = newCircleRect.origin.x // x coord
        let trailing = newCircleRect.origin.x + newCircleRect.size.width // width
        let bottom = newCircleRect.origin.y + newCircleRect.size.height // height
        let top = newCircleRect.origin.y // y coord

        let edgeInsets = EdgeInsets(leading: leading,
                                    trailing: trailing,
                                    bottom: bottom,
                                    top: top)

        return edgeInsets
    }

    func addInnerText(atPosition position: Position, _ string: String, color: UIColor) {
        let textRect = CGRect(x: offsetX, y: offsetY, width: rect.width, height: rect.height)
        DrawableText.shared.drawInner(atPosition: position, in: textRect, string, color: color)
    }

    func color(_ color: UIColor) {
        self.color = color
    }
}
