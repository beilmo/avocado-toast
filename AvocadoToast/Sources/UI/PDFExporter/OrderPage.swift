//
//  OrderPage.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 10/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import PDFKit

class WatermarkPage: PDFPage {

    // 3. Override PDFPage custom draw
    /// - Tag: OverrideDraw
    override func draw(with box: PDFDisplayBox, to context: CGContext) {

        // Draw original content
        super.draw(with: box, to: context)

        // Draw string
        UIGraphicsPushContext(context)
        context.saveGState()

        let string1: NSString = "Am o paine"
        let attributes1 = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 64)
        ]

        let string2 = "Am o lopata"
        let attributes2 = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 64)
        ]

        string1.draw(at: CGPoint(x: 250, y: 40), withAttributes: attributes1)
        string2.draw(at: CGPoint(x: 250, y: 60), withAttributes: attributes2)

        context.restoreGState()
        UIGraphicsPopContext()

    }
}
