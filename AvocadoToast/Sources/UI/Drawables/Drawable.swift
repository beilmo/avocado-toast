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

protocol DrawableOperations {
    func draw(element: Any)
    func alignment(_ alignment: Alignment)
    func offset(_ offset: CGFloat)
}

enum ElementType {
    case text
    case image
    case circle
}

struct ElementDrawer<T> {
    private var drawableObject: T

    func offset(_ offset: CGFloat) {
        
    }

    func draw(element: T) -> EdgeInsets {
        return EdgeInsets()
    }

    // used to verify if the drawing could be completed based on the result of type Bool
    // the result will be false when the element cannot be drew due to the lack of space
    func draw(element: T, completion: (Bool) -> ()) -> EdgeInsets {
        return EdgeInsets()
    }

    func alignment(_ alignment: Alignment) {
        
    }

    var rect: CGRect
}
