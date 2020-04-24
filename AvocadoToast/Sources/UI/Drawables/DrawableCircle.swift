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

class DrawableCircle: Drawable {
    private var rect: CGRect = .zero

    private var size: CGFloat = {
        if let size = Coordinator.shared.elementsRect.last?.height {
            return size
        }
        return 20
    }()

    private var color: UIColor = .label

    static private var customCircle = DrawableCircle()

    init(rect: CGRect = .zero, size: CGFloat = 20, color: UIColor = .label) {
        super.init()
        self.rect = rect
        self.size = size
        self.color = color
        align()
        draw()
    }
}

extension DrawableCircle {

    private func draw() {

        let circleCGPath = Circle().path(in: CGRect(x: 0, y: 0, width: size, height: size))

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))

        let circleImage = renderer.image { (context) in
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.addPath(circleCGPath.cgPath)
            context.cgContext.drawPath(using: .fill)
        }

        Coordinator.shared.draw(element: circleImage)
    }

    @discardableResult
    func addInnerText(string: String, font: CGFloat, alignment: Alignment, color: UIColor) -> DrawableCircle {
        DrawableText().drawInner(string: string, font: font, alignment: alignment, in: rect, color: color)
        return self
    }

    func align(elementAlignment: Alignment = .default) {

        var lastElementRect = EdgeInsets()
        if Coordinator.shared.elementsEdges.count > 0 {
            lastElementRect = Coordinator.shared.elementsEdges.last!
        }

        switch elementAlignment {
        case .center:
            rect = CGRect(
                x: (paperSize.sizeInPoints.width - rect.width) / 2.0,
                y: lastElementRect.bottom,
                width: rect.width,
                height: rect.height
            )
        case .leading:
            rect = CGRect(
                x: 36,
                y: lastElementRect.bottom,
                width: rect.width,
                height: rect.height
            )
        case .trailing:
            rect = CGRect(
                x: (paperSize.sizeInPoints.width - rect.width),
                y: lastElementRect.bottom,
                width: rect.width,
                height: rect.height
            )
        default:
            rect = CGRect(
                x: lastElementRect.trailing,
                y: lastElementRect.top,
                width: size,
                height: size
            )
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
    }

    @discardableResult
    func size(_ size: CGFloat) -> DrawableCircle {
        self.size = size
        let newCircle = DrawableCircle(size: size)
        DrawableCircle.customCircle = newCircle
        Coordinator.shared.removeLastEntries()
        return self
    }

    @discardableResult
    func color(_ color: UIColor) -> DrawableCircle {
        self.color = color
        Coordinator.shared.removeLastEntries()
        return self
    }
}
