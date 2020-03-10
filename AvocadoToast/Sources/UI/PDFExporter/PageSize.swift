//
//  PageSize.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 11/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

extension Float {
    fileprivate var inPaperSizePoints: Float {
        let pt = self / (25.4 / 72)
        return pt.rounded()
    }
}

struct PaperSize {
    let width: Float // mm
    let height: Float // mm
}

extension PaperSize {
    static let A0 = PaperSize(width: 841, height: 1189)
    static let A1 = PaperSize(width: 594, height: 841)
    static let A2 = PaperSize(width: 420, height: 594)
    static let A3 = PaperSize(width: 297, height: 420)
    static let A4 = PaperSize(width: 210, height: 297)
}

extension PaperSize {
    var sizeInPoints: CGSize {
        return CGSize(width: CGFloat(width.inPaperSizePoints),
                      height: CGFloat(height.inPaperSizePoints))
    }
}
