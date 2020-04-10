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

    func addText(string: String, font: CGFloat, position: Position, alignment: Alignment) {

        let attributedString = getAttributedString(string: string, font: font, color: .label)

        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)

        var stringRect = attributedString.rect(containerWidth: paperSize.sizeInPoints.width * 0.8)

        align(in: stringRect, textAlignment: .center, position: .onTheNextLine)

        var alignedRect = Coordinator.shared.elementsRect.last!
        var currentRange = CFRangeMake(0, 0)
        var currentPage = 0
        var done = false
        repeat {

            /* Draw a page number at the bottom of each page. */
            currentPage += 1
            //drawPageNumber(currentPage)

            /* Render the current page and update the current range to
              point to the beginning of the next page. */
            currentRange = renderPage(rect: alignedRect,
                                      withTextRange: currentRange,
                                      andFramesetter: framesetter)

            /* If we're at the end of the text, exit the loop. */
            if currentRange.location == CFAttributedStringGetLength(attributedString) {
                done = true
            } else {
                /* Mark the beginning of a new page. */
                context.beginPage()
                //var remainingTextRect = CGRect()

                print(Coordinator.shared.elementsRect)
                print(Coordinator.shared.elementsEdges)
                if let lastTextRect = Coordinator.shared.elementsRect.last {
                    print("Da:",stringRect)
                    stringRect = CGRect(x: stringRect.origin.x,
                                        y: stringRect.origin.y,
                                        width: stringRect.width,
                                        height: stringRect.height - (paperSize.sizeInPoints.height - lastTextRect.origin.y)+1.83)
                    print("Da dupa:",stringRect)
                    align(in: stringRect, textAlignment: .center, position: .onTheNextLine)
                    alignedRect = Coordinator.shared.elementsRect.last!
                    alignedRect = CGRect(x: alignedRect.origin.x, y: 0, width: alignedRect.width, height: alignedRect.height)
//                    stringRect = CGRect(x: 0,
//                                        y: 0,
//                                        width: stringRect.width,
//                                        height: lastTextRect.bottom + stringRect.height - paperSize.sizeInPoints.height)
//                    align(in: stringRect, textAlignment: .center, position: .onTheNextLine)
//                    alignedRect = Coordinator.shared.elementsRect.last!
                    //print("Pula")
                } else {
//                    print("Da:",stringRect)
//                    stringRect = CGRect(x: 0,
//                                        y: 0,
//                                        width: stringRect.width,
//                                        height: paperSize.sizeInPoints.height - stringRect.origin.y - stringRect.height)
//                    print("Da dupa:",stringRect)
//                    align(in: stringRect, textAlignment: .center, position: .onTheNextLine)
//                    alignedRect = Coordinator.shared.elementsRect.last!
                }

                Coordinator.shared.clearCache()



                print("Next Page")


            }

        } while !done

        print(CGFloat(currentRange.location + currentRange.length))



//        let leading = stringRect.origin.x // x coord
//        let trailing = stringRect.origin.x + stringRect.size.width // width
//        let bottom = stringRect.origin.y + stringRect.size.height // height
//        let top = stringRect.origin.y // y coord
//
//        let edgeInsets = EdgeInsets(leading: leading,
//                                    trailing: trailing,
//                                    bottom: bottom,
//                                    top: top)
//
//        Coordinator.shared.addElementEdges(edgeInsets)
//        Coordinator.shared.addElementRect(stringRect)
        context.cgContext.scaleBy(x: 1.0, y: -1.0)
    }

    func renderPage(rect: CGRect, withTextRange currentRange: CFRange, andFramesetter framesetter: CTFramesetter?) -> CFRange {
        var currentRange = currentRange
        var rect = rect
        // Get the graphics context.
        let currentContext = context.cgContext

        /* Put the text matrix into a known state. This ensures
            that no old scaling factors are left in place. */
        currentContext.textMatrix = .identity

        /* Create a path object to enclose the text. Use 72 point
            margins all around the text. */
//        var previousStringRect = EdgeInsets()
//        if Coordinator.shared.elementsEdges.count > 0 {
//            previousStringRect = Coordinator.shared.elementsEdges.last!
//            print(previousStringRect)
//        }

//        let frameRect = CGRect(x: 0,
//                               y: previousStringRect.bottom,
//                               width: rect.width,
//                               height: rect.height)
        print(rect)
        let framePath = CGMutablePath()
        if rect.origin.y + rect.height > paperSize.sizeInPoints.height {
            let truncatedHeight = paperSize.sizeInPoints.height - rect.origin.y
            let truncatedRect = CGRect(x: rect.origin.x,
                                       y: 0,
                                       width: rect.width,
                                       height: truncatedHeight)
            print("truncated rect:", truncatedRect)
            rect = truncatedRect
            framePath.addRect(rect, transform: .identity)
        } else {
            let truncatedRect = CGRect(x: rect.origin.x,
                                       y: 0,
                                       width: rect.width,
                                       height: rect.height)
            rect = truncatedRect
            framePath.addRect(truncatedRect, transform: .identity)
        }

        // Get the frame that will do the rendering.
        // The currentRange variable specifies only the starting point. The framesetter
        // lays out as much text as will fit into the frame.
        let frameRef = CTFramesetterCreateFrame(framesetter!, currentRange, framePath, nil)

        // Core Text draws from the bottom-left corner up, so flip
        // the current transform prior to drawing.

        if rect.origin.y == 0 {
            currentContext.translateBy(x: 0, y: rect.height)

        } else {
            currentContext.translateBy(x: 0, y: (rect.height)) // this fucker
            print("y: ",rect.origin.y)
            //currentContext.scaleBy(x: 1.0, y: -1.0)
        }

        currentContext.scaleBy(x: 1.0, y: -1.0)

        // Draw the frame.
        CTFrameDraw(frameRef, currentContext)

        // Update the current range based on what was drawn.
        currentRange = CTFrameGetVisibleStringRange(frameRef)
        currentRange.location += currentRange.length
        currentRange.length = CFIndex(0)

        return currentRange
    }

    func drawPageNumber(_ pageNum: Int) {

        let pageString = getAttributedString(string: "Page \(pageNum)", font: 20, color: .label)

        let pageStringSize = pageString.size()

        let stringRect = CGRect(x: (paperSize.sizeInPoints.width - pageStringSize.width) / 2.0,
                                y: paperSize.sizeInPoints.height * 0.95,
                                width: pageStringSize.width,
                                height: pageStringSize.height)

        pageString.draw(in: stringRect)
    }





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
        return CGRect(x: rect.origin.x, y: rect.origin.y, width: ceil(rect.size.width), height: ceil(rect.size.height)+1)
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
