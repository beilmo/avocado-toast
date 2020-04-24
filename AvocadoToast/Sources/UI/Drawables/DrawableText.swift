//
//  DrawableText.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 12/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

class DrawableText: Drawable {

}

extension DrawableText {

    func addText(string: String, font: CGFloat, position: Position, alignment: Alignment) {

        let attributedString = getAttributedString(string: string, font: font, color: .label)

        var stringRect = attributedString.rect(containerWidth: paperSize.sizeInPoints.width * 0.8)

        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)

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
                print("Done rendering")
            } else {
                /* Mark the beginning of a new page. */
                context!.beginPage()
                
                //determines the rect height for the left string range
                //the entire text is not fitting the current page, so we determine the remaining rect necessary to draw the rest
                // rect dimensions are determined by calculating the range of characters left to draw from string
                Coordinator.shared.clearCache()
                let attributedStringSize = attributedString.getSize(containerWidth: paperSize.sizeInPoints.width * 0.8, currentRange: (CFAttributedStringGetLength(attributedString) - currentRange.location))

                stringRect = CGRect(origin: .zero, size: attributedStringSize)
                align(in: stringRect, textAlignment: .center, position: .onTheNextLine)
                alignedRect = Coordinator.shared.elementsRect.last!
                alignedRect = CGRect(x: alignedRect.origin.x, y: 0, width: alignedRect.width, height: alignedRect.height)

                //print("Next Page")
            }
        } while !done

        print(CGFloat(currentRange.location + currentRange.length))

        //defines the coords system to be efective with positive values on axis as it should be
        context!.cgContext.scaleBy(x: 1.0, y: -1.0)
    }

    func renderPage(rect: CGRect, withTextRange currentRange: CFRange, andFramesetter framesetter: CTFramesetter?) -> CFRange {
        var currentRange = currentRange
        var rect = rect
        // Get the graphics context.
        let currentContext = context!.cgContext

        /* Put the text matrix into a known state. This ensures
            that no old scaling factors are left in place. */
        currentContext.textMatrix = .identity

        /* Create a path object to enclose the text. Use 72 point
            margins all around the text. */
        // When drawing in an opposite Y position (CoreText bottom-left axis system) we need to substract the origin of Y and the height in order to render at the desired position, because the drawing is realised from the bottom to top
        
        //print(rect)
        if rect.origin.y + rect.height > paperSize.sizeInPoints.height {
            let truncatedHeight = paperSize.sizeInPoints.height - rect.origin.y
            let truncatedRect = CGRect(x: rect.origin.x,
                                       y: -(rect.origin.y + truncatedHeight),
                                       width: rect.width,
                                       height: truncatedHeight)
            rect = truncatedRect
        } else {
            let newRect = CGRect(x: rect.origin.x,
                                 y: -(rect.origin.y + rect.height),
                                 width: rect.width,
                                 height: rect.height)
            rect = newRect
        }

        let framePath = CGMutablePath()
        framePath.addRect(rect, transform: .identity)

        // Get the frame that will do the rendering.
        // The currentRange variable specifies only the starting point. The framesetter
        // lays out as much text as will fit into the frame.
        let frameRef = CTFramesetterCreateFrame(framesetter!, currentRange, framePath, nil)

        // Core Text draws from the bottom-left corner up, so flip
        // the current transform prior to drawing.
        currentContext.translateBy(x: 0, y: 0)
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
        default:
            break
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
            default:
                break
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
            default:
                break
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
        let size = getSize(containerWidth: containerWidth)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)

        //print("rect:",rect)
        return rect
    }

    func getSize(containerWidth: CGFloat) -> CGSize {
        let maxSize = CGSize(width: containerWidth, height: .greatestFiniteMagnitude)
        let range = CFRangeMake(0, self.string.count)
        let framesetter = CTFramesetterCreateWithAttributedString(self)
        let framesetterSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, nil, maxSize, nil)

        return framesetterSize
    }
    func getSize(containerWidth: CGFloat, currentRange: CFIndex) -> CGSize {
        let maxSize = CGSize(width: containerWidth, height: .greatestFiniteMagnitude)
        let range = CFRangeMake(0, currentRange)
        let framesetter = CTFramesetterCreateWithAttributedString(self)
        let framesetterSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, nil, maxSize, nil)

        return framesetterSize
    }
}
