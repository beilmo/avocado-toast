//
//  DrawableText.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 12/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

class DrawableText {
    let paperSize: PaperSize
    let context: UIGraphicsPDFRendererContext

    init(paperSize: PaperSize, context: UIGraphicsPDFRendererContext) {
        self.paperSize = paperSize
        self.context = context
    }

    static let shared = DrawableText(paperSize: .A4, context: UIGraphicsPDFRendererContext())

    func drawInner(alignment: Alignment, in rect: CGRect, _ string: String, color: UIColor) {

        let textFont = UIFont.preferredFont(forTextStyle: .body)
        let textAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: textFont,
             NSAttributedString.Key.foregroundColor: color]
        let attributedText = NSAttributedString(
            string: string,
            attributes: textAttributes
        )

        let textStringSize = attributedText.size()
        var textStringRect = CGRect()

        switch alignment {
        case .center:
            textStringRect = CGRect(
                x: rect.minX + (rect.width - textStringSize.width) / 2.0,
                y: rect.minY + (rect.height - textStringSize.height) / 2.0,
                width: textStringSize.width,
                height: textStringSize.height
            )
        case .leading:
            textStringRect = CGRect(
                x: rect.minX + rect.width * 0.05,
                y: rect.minY + (rect.height - textStringSize.height) / 2.0,
                width: textStringSize.width,
                height: textStringSize.height
            )
        case .trailing:
            textStringRect = CGRect(
                x: rect.minX + (rect.width - textStringSize.width) - rect.width * 0.05,
                y: rect.minY + (rect.height - textStringSize.height) / 2.0,
                width: textStringSize.width,
                height: textStringSize.height
            )
        }

        attributedText.draw(in: textStringRect)
    }

    func drawTitle(alignment: Alignment, _ title: String) -> CGFloat {

        let titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: titleAttributes
        )

        let titleStringSize = attributedTitle.size()
        var titleStringRect = CGRect()

        switch alignment {
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

    func drawText(alignment: Alignment, _ string: String, offsetY: CGFloat) -> EdgeInsets {

        let textFont = UIFont.preferredFont(forTextStyle: .body)
        let textAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: textFont]
        let attributedText = NSAttributedString(
            string: string,
            attributes: textAttributes
        )

        let textStringSize = attributedText.size()
        var textStringRect = CGRect()

        switch alignment {
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

        let leading = textStringRect.origin.x // x coord
        let trailing = textStringRect.origin.x + textStringRect.size.width // width
        let bottom = textStringRect.origin.y + textStringRect.size.height // height
        let top = textStringRect.origin.y // y coord

        let edgeInsets = EdgeInsets(leading: leading,
                                    trailing: trailing,
                                    bottom: bottom,
                                    top: top)

        return edgeInsets
    }

    func drawParagraphText(rectAlignment: Alignment, textAlignment: NSTextAlignment, string: String, offsetY: CGFloat) -> EdgeInsets {
        let textFont = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = .byWordWrapping

        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]

        let attributedText = NSAttributedString(string: string, attributes: textAttributes)

        let stringTextSizeHeight = string.height(withConstrainedWidth: CGFloat(paperSize.sizeInPoints.width) * 0.8, font: .systemFont(ofSize: 17))
        var labelRect = CGRect(x: 0, y: offsetY, width: CGFloat(paperSize.sizeInPoints.width) * 0.8, height: stringTextSizeHeight-50)

        let label = UILabel(frame: labelRect)
        label.numberOfLines = 0

        let words = string.components(separatedBy: .whitespaces)

        label.attributedText = attributedText
        //print(labelRect)
        //print(label.frame)

        switch rectAlignment {
        case .center:
            labelRect = CGRect(
                x: (paperSize.sizeInPoints.width - labelRect.width) / 2.0,
                y: offsetY,
                width: labelRect.width,
                height: label.frame.height
            )
        case .leading:
            labelRect = CGRect(
                x: paperSize.sizeInPoints.width * 0.05,
                y: offsetY,
                width: labelRect.width,
                height: label.frame.height
            )
        case .trailing:
            labelRect = CGRect(
                x: paperSize.sizeInPoints.width - labelRect.width - paperSize.sizeInPoints.width * 0.05,
                y: offsetY,
                width: labelRect.width,
                height: label.frame.height
            )
        }

        if (label.frame.height + offsetY) < paperSize.sizeInPoints.height {

            //print(labelRect)
            //print(label.frame)

            label.drawText(in: labelRect)
        } else { // this executes when an entire paragraph doesn't fit the remaining space

            var rowMultiplier: CGFloat = 1

            var composedString = ""
            var rowString = ""
            for word in words {
                let composedAttributedText = NSAttributedString(string: composedString, attributes: textAttributes)
                let rowAttributedText = NSAttributedString(string: rowString, attributes: textAttributes)
                let wordAttributedText = NSAttributedString(string: word, attributes: textAttributes)

                let stringTextSize = composedAttributedText.size()
                let rowStringTextSize = rowAttributedText.size()
                let wordTextSize = wordAttributedText.size()
                label.attributedText = composedAttributedText

                //print("label frame2:" ,label.frame)
                //print("string width:",rowStringTextSize.width)
                //print("word:", wordTextSize.width)
                if label.frame.width <= rowStringTextSize.width + wordTextSize.width {
                    rowMultiplier = rowMultiplier + 1
                    composedString += rowString
                    //print("Composed String:", composedString)
                    rowString = ""
                }

                if rowMultiplier * stringTextSize.height < paperSize.sizeInPoints.height - offsetY {
                    labelRect = CGRect(x: 36, y: offsetY, width: CGFloat(paperSize.sizeInPoints.width) * 0.8, height: rowMultiplier * stringTextSize.height)
                    label.frame = labelRect
                    //print("Label rect:" ,labelRect)
                    //print("label frame:" ,label.frame)
                    //print("label height+offset: \(label.frame.height + offsetY) -- page height: \(paperSize.sizeInPoints.height)")
                    rowString += "\(word) "

                    //print("Row String:", rowString)
                } else {
                    print("create new page with words: \(word)")
                }
            }
            label.drawText(in: labelRect)
            //print("Cannot draw this on the current page. Need start a new page")
        }

        let leading = labelRect.origin.x // x coord
        let trailing = labelRect.origin.x + labelRect.size.width // width
        let bottom = labelRect.origin.y + labelRect.size.height // height
        let top = labelRect.origin.y // y coord

        let edgeInsets = EdgeInsets(leading: leading,
                                    trailing: trailing,
                                    bottom: bottom,
                                    top: top)

        return edgeInsets
    }
}

extension NSAttributedString {

    func height(containerWidth: CGFloat) -> CGFloat {

        let rect = self.boundingRect(with: CGSize.init(width: containerWidth, height: CGFloat.greatestFiniteMagnitude),
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil)
        return ceil(rect.size.height)
    }

    func width(containerHeight: CGFloat) -> CGFloat {

        let rect = self.boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: containerHeight),
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil)
        return ceil(rect.size.width)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
