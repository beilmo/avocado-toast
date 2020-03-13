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

    init(paperSize: PaperSize) {
        self.paperSize = paperSize
    }

    static let shared = DrawableText(paperSize: .A4)

    func drawInner(atPosition position: Position, in rect: CGRect, _ string: String, color: UIColor) {

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

        switch position {
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

    func drawTitle(atPosition position: Position, _ title: String) -> CGFloat {

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

    func drawText(atPosition position: Position, _ string: String, offsetY: CGFloat) -> EdgeInsets {

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
}
