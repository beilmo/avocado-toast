//
//  DrawableImage.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 12/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

class DrawableImage {
    let paperSize: PaperSize

    init(paperSize: PaperSize) {
           self.paperSize = paperSize
    }

    static let shared = DrawableImage(paperSize: .A4)

    func draw(atPosition position: Position, _ image: UIImage, offsetY: CGFloat) -> CGFloat {

        let maxHeight = paperSize.sizeInPoints.height * 0.4
        let maxWidth = paperSize.sizeInPoints.width * 0.8

        let aspectWidth = maxWidth / image.size.width
        let aspectHeight = maxHeight / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)

        let scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio

        let imageX = (paperSize.sizeInPoints.width - scaledWidth) / 2.0
        let imageRect = CGRect(x: imageX,
                               y: offsetY,
                               width: scaledWidth,
                               height: scaledHeight)

        image.draw(in: imageRect)

        return imageRect.origin.y + imageRect.size.height
    }
}
