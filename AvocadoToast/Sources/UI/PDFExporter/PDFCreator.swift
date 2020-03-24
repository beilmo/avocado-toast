//
//  PDFCreator.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 10/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import CoreGraphics
import SwiftUI
import UIKit

class PDFCreator: PDFOperations {

    var paperSize: PaperSize
    var presenter: OrderPresenter

    init(paperSize: PaperSize, presenter: OrderPresenter) {
        self.paperSize = paperSize
        self.presenter = presenter
    }

    func create() -> Data {

        let pdfMetadata = [
            // The name of the application creating the PDF.
            kCGPDFContextCreator: "Avocado Toast App",

            // The name of the PDF's author.
            kCGPDFContextAuthor: "Order Processor",

            // The title of the PDF.
            kCGPDFContextTitle: "Order",
        ]

        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetadata as [String: Any]

        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: paperSize.sizeInPoints), format: format)

        let data = renderer.pdfData { (context) in
            context.beginPage()

            //DrawableElements
            DrawableData().render(context: context)

//            let titleText = DrawableText(paperSize: paperSize, context: context).drawTitle(alignment: .center, presenter.summary)
//            let timestampText = DrawableText(paperSize: paperSize, context: context).drawText(alignment: .leading, presenter.purchaseDate, offsetY: (titleText + paperSize.sizeInPoints.height * 0.1))
//            let quantityText = DrawableText(paperSize: paperSize, context: context).drawText(alignment: .leading, presenter.quantity, offsetY: timestampText.bottom + paperSize.sizeInPoints.height * 0.01)
//
//            let toppings = "Toppings: "
//            let toppingsText = DrawableText(paperSize: paperSize, context: context).drawText(alignment: .leading, toppings, offsetY: quantityText.bottom + paperSize.sizeInPoints.height * 0.01)
//
//            let circleDiameter = toppingsText.bottom - toppingsText.top
//
//            var toppingsPosition: [EdgeInsets] = []
//            var circlePosition = EdgeInsets()
//
//            for topping in presenter.toppings {
//                var textColor = UIColor.systemBackground
//                let circle = DrawableCircle(rect: CGRect(x: 0, y: 0, width: circleDiameter, height: circleDiameter))
//
//                switch topping {
//                case .salt:
//                    circle.color(.label)
//                case .redPepperFlakes:
//                    circle.color(.systemRed)
//                    textColor = .label
//                case .egg:
//                    circle.color(.systemYellow)
//                    textColor = .label
//                }
//
//                if toppingsPosition.count > 0 {
//                    circlePosition = circle.draw(offsetX: toppingsPosition[toppingsPosition.count-1].trailing, offsetY: toppingsPosition[toppingsPosition.count-1].top)
//                } else {
//                    circlePosition = circle.draw(offsetX: toppingsText.trailing, offsetY: toppingsText.top)
//                }
//                toppingsPosition.append(circlePosition)
//
//                circle.addInnerText(alignment: .center, topping.abbreviation, color: textColor)
//            }
//
//            let toastImage = DrawableImage(paperSize: paperSize).draw(alignment: .center, presenter.image, offsetY: toppingsText.bottom)
//
//            //let words = String.loremIpsum.components(separatedBy: .whitespacesAndNewlines)
//            //let words = stringComponents.filter( { $0.isEmpty } )
//            //print(words)
//
//            let paragraph = DrawableText(paperSize: paperSize, context: context).drawParagraphText(rectAlignment: .center, textAlignment: .justified, string: .loremIpsum, offsetY: toastImage.bottom)
//            let paragraph2 = DrawableText(paperSize: paperSize, context: context).drawParagraphText(rectAlignment: .center, textAlignment: .justified, string: .loremIpsum, offsetY: paragraph.bottom)
//            let paragraph3 = DrawableText(paperSize: paperSize, context: context).drawParagraphText(rectAlignment: .center, textAlignment: .justified, string: .loremIpsum, offsetY: paragraph2.bottom)
        }

        return data
    }
}
