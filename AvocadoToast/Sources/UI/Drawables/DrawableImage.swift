//
//  DrawableImage.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 12/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

class DrawableImage: Drawable {

}

extension DrawableImage {

    func draw(image: UIImage, alignment: Alignment) {

        let maxHeight = paperSize.sizeInPoints.height * 0.4
        let maxWidth = paperSize.sizeInPoints.width * 0.8

        let aspectWidth = maxWidth / image.size.width
        let aspectHeight = maxHeight / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)

        let scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio

        var previousStringRect = EdgeInsets()
        if Coordinator.shared.elementsEdges.count > 0 {
            previousStringRect = Coordinator.shared.elementsEdges.last!
        }

        var imageRect = CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight)

        switch alignment {
        case .center:
            imageRect = CGRect(
                x: (paperSize.sizeInPoints.width - scaledWidth) / 2.0,
                y: previousStringRect.bottom,
                width: scaledWidth,
                height: scaledHeight
            )
        case .leading:
            imageRect = CGRect(
                x: 36,
                y: previousStringRect.bottom,
                width: scaledWidth,
                height: scaledHeight
            )
        case .trailing:
            imageRect = CGRect(
                x: (paperSize.sizeInPoints.width - imageRect.width),
                y: previousStringRect.bottom,
                width: scaledWidth,
                height: scaledHeight
            )
        default:
            break
        }

        let leading = imageRect.origin.x // x coord
        let trailing = imageRect.origin.x + imageRect.size.width // width
        let bottom = imageRect.origin.y + imageRect.size.height // height
        let top = imageRect.origin.y // y coord

        let edgeInsets = EdgeInsets(leading: leading,
                                    trailing: trailing,
                                    bottom: bottom,
                                    top: top)

        Coordinator.shared.addElementEdges(edgeInsets)
        Coordinator.shared.addElementRect(imageRect)
        Coordinator.shared.draw(element: image)
    }
}
