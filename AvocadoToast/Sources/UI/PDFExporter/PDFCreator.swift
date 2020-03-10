//
//  PDFCreator.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 10/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import CoreGraphics
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
            
            let title = addTitle(atPosition: .center, presenter.summary)
            let timestamp = addText(atPosition: .leading, presenter.purchaseDate, offsetY: (title + paperSize.sizeInPoints.height * 0.1))
            let quantity = addText(atPosition: .leading, presenter.quantity, offsetY: timestamp + paperSize.sizeInPoints.height * 0.01)

            var toppings = "Toppings: "
            var toppingsArray: [String] = []
            for topping in presenter.toppings {
                toppingsArray.append(topping.rawValue)
            }
            toppings += toppingsArray.joined(separator: ", ")

            let toppingsOnToast = addText(atPosition: .leading, toppings, offsetY: quantity + paperSize.sizeInPoints.height * 0.01)

            _ = addImage(atPosition: .center, presenter.image, offsetY: toppingsOnToast)
        }

        return data
    }

    func addTitle(atPosition position: Position, _ title: String) -> CGFloat {

        let titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: titleAttributes
        )

        let titleStringSize = attributedTitle.size()
        var titleStringRect = CGRect()

        switch position {
        case .center:
            titleStringRect = CGRect(
                x: (paperSize.sizeInPoints.width - titleStringSize.width) / 2.0,
                y: 36,
                width: titleStringSize.width,
                height: titleStringSize.height
            )
        case .leading:
            titleStringRect = CGRect(
                x: 36,
                y: 36,
                width: titleStringSize.width,
                height: titleStringSize.height
            )
        case .trailing:
            titleStringRect = CGRect(
                x: (paperSize.sizeInPoints.width - titleStringSize.width),
                y: 36,
                width: titleStringSize.width,
                height: titleStringSize.height
            )
        }

        attributedTitle.draw(in: titleStringRect)

        return titleStringRect.origin.y + titleStringRect.size.height
    }

    func addText(atPosition position: Position, _ string: String, offsetY: CGFloat) -> CGFloat {

        let textFont = UIFont.preferredFont(forTextStyle: .body)
        let textAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: textFont]
        let attributedText = NSAttributedString(
            string: string,
            attributes: textAttributes
        )

        let textStringSize = attributedText.size()
        var textStringRect = CGRect()

        switch position {
        case .center:
            textStringRect = CGRect(
                x: (paperSize.sizeInPoints.width - textStringSize.width) / 2.0,
                y: offsetY,
                width: textStringSize.width,
                height: textStringSize.height
            )
        case .leading:
            textStringRect = CGRect(
                x: 36,
                y: offsetY,
                width: textStringSize.width,
                height: textStringSize.height
            )
        case .trailing:
            textStringRect = CGRect(
                x: (paperSize.sizeInPoints.width - textStringSize.width),
                y: offsetY,
                width: textStringSize.width,
                height: textStringSize.height
            )
        }

        attributedText.draw(in: textStringRect)

        return textStringRect.origin.y + textStringRect.size.height
    }

    func addImage(atPosition position: Position, _ image: UIImage, offsetY: CGFloat) -> CGFloat {

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

enum Position {
    case center
    case trailing
    case leading
}

