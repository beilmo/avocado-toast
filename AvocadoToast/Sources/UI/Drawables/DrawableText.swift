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
}

extension DrawableText {

    func drawInner(string: String, font: CGFloat, alignment: Alignment, in rect: CGRect, color: UIColor) {
        let attributedString = getAttributedString(string: string, font: font, color: color)
        var stringRect = attributedString.rect(containerWidth: rect.width)

        switch alignment {
        case .center:
            stringRect = CGRect(
                x: rect.minX + (rect.width - stringRect.width) / 2.0,
                y: rect.minY + (rect.height - stringRect.height) / 2.0,
                width: stringRect.width,
                height: stringRect.height
            )
        case .leading:
            stringRect = CGRect(
                x: rect.minX + rect.width * 0.05,
                y: rect.minY + (rect.height - stringRect.height) / 2.0,
                width: stringRect.width,
                height: stringRect.height
            )
        case .trailing:
            stringRect = CGRect(
                x: rect.minX + (rect.width - stringRect.width) - rect.width * 0.05,
                y: rect.minY + (rect.height - stringRect.height) / 2.0,
                width: stringRect.width,
                height: stringRect.height
            )
        }
        //Coordinator.shared.addElementRect(textStringRect)
        //Coordinator.shared.draw(element: attributedString)
        attributedString.draw(in: stringRect)
    }

    func draw(string: String, font: CGFloat, position: Position, alignment: Alignment) {
        let attributedString = getAttributedString(string: string, font: font, color: .label)
        let stringRect = attributedString.rect(containerWidth: paperSize.sizeInPoints.width * 0.8)

        align(in: stringRect, textAlignment: alignment, position: position)

        Coordinator.shared.draw(element: attributedString)
    }

    func getAttributedString(string: String, font: CGFloat, color: UIColor) -> NSAttributedString {
        let stringFont = UIFont.systemFont(ofSize: font)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping

        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: stringFont,
            NSAttributedString.Key.foregroundColor: color
        ]

        return NSAttributedString(string: string, attributes: textAttributes)
    }

    func align(in rect: CGRect, textAlignment: Alignment, position: Position) {
        var rect = rect

        var previousStringRect = EdgeInsets()
        if Coordinator.shared.elementsEdges.count > 0 {
            previousStringRect = Coordinator.shared.elementsEdges.last!
        }

        switch position {
        case .onTheNextLine:
            switch textAlignment {
            case .center:
                rect = CGRect(
                    x: (paperSize.sizeInPoints.width - rect.width) / 2.0,
                    y: previousStringRect.bottom,
                    width: rect.width,
                    height: rect.height
                )
            case .leading:
                rect = CGRect(
                    x: 36,
                    y: previousStringRect.bottom,
                    width: rect.width,
                    height: rect.height
                )
            case .trailing:
                rect = CGRect(
                    x: (paperSize.sizeInPoints.width - rect.width),
                    y: previousStringRect.bottom,
                    width: rect.width,
                    height: rect.height
                )
            }
        case .onTheSameLine:
            switch textAlignment {
            case .center:
                rect = CGRect(
                    x: (paperSize.sizeInPoints.width - previousStringRect.trailing) / 2.0,
                    y: rect.origin.y,
                    width: paperSize.sizeInPoints.width,
                    height: rect.height
                )
            case .leading:
                rect = CGRect(
                    x: 36,
                    y: rect.origin.y,
                    width: rect.width,
                    height: rect.height
                )
            case .trailing:
                rect = CGRect(
                    x: (paperSize.sizeInPoints.width - previousStringRect.trailing),
                    y: rect.origin.y,
                    width: rect.width,
                    height: rect.height
                )
            }
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
            var supplementString = ""
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
                    supplementString += "\(word) "
                    print("create new page with words: \(word)")
//                    context.beginPage()
//                    composedString += "\(word) "
//                    label.attributedText = NSAttributedString(string: composedString, attributes: textAttributes)
                }
            }
            label.drawText(in: labelRect)
            if !supplementString.isEmpty {
                context.beginPage()
                label.frame = CGRect(x: 0, y: 0, width: CGFloat(paperSize.sizeInPoints.width) * 0.8, height: stringTextSizeHeight-50)
                let attributedText = NSAttributedString(string: supplementString, attributes: textAttributes)
                label.attributedText = attributedText
                label.drawText(in: label.frame)
            }
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
        let size = CGSize(width: containerWidth, height: .greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size,
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

    func rect(containerWidth: CGFloat) -> CGRect {
        let size = CGSize(width: containerWidth, height: .greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size,
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil)
        return rect
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
