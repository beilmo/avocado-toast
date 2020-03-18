//
//  Drawable.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 13/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit


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

protocol DrawableOperations {
    func draw(element: Any)
    func alignment(_ alignment: Alignment)
    func offset(_ offset: CGFloat)
}

struct Drawable: DrawableOperations {
    private var drawableObject: Any

    func offset(_ offset: CGFloat) {
        
    }

    func draw(element: Any) {
        
    }

    func alignment(_ alignment: Alignment) {
        
    }

    var rect: CGRect
}
