//
//  Drawable.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 13/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

enum Position {
    case onTheSameLine
    case onTheNextLine
    //case embedded
}

enum Alignment {
    case center
    case trailing
    case leading
    case `default`
}

struct EdgeInsets {
    var leading: CGFloat = 0
    var trailing: CGFloat = 0
    var bottom: CGFloat = 0
    var top: CGFloat = 0
}

extension EdgeInsets {
    func toRect() -> CGRect {
        return CGRect(x: leading, y: top, width: trailing, height: bottom)
    }
}

extension EdgeInsets: Equatable {
    static func == (lhs: EdgeInsets, rhs: EdgeInsets) -> Bool {
        return lhs.bottom == rhs.bottom &&
            lhs.top == rhs.top &&
            lhs.leading == rhs.leading &&
            lhs.trailing == rhs.trailing
    }
}

class DrawableContext<T> where T: UIGraphicsPDFRendererContext {
    let context: T

    init(context: T) {
        self.context = context
    }
}

class DrawableEnvironment {
    static var context: UIGraphicsPDFRendererContext? = nil
    static var paperSize: PaperSize = .A4
}

class Drawable: DrawableEnvironment {
    var context: UIGraphicsPDFRendererContext? = DrawableEnvironment.context
    var paperSize: PaperSize = DrawableEnvironment.paperSize
}
