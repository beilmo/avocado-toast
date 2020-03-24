//
//  DrawableData.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 20/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

struct DrawableData {
    func render(context: UIGraphicsPDFRendererContext) {
        //paper size
        let paperSize: PaperSize = .A4
        
        //DrawableElements
        let drawableText = DrawableText(paperSize: paperSize, context: context)

        drawableText.draw(string: "Ana are mere", font: 50, position: .onTheNextLine, alignment: .center)
        drawableText.draw(string: .loremIpsum, font: 17, position: .onTheNextLine, alignment: .leading)
        drawableText.draw(string: .loremIpsum, font: 17, position: .onTheNextLine, alignment: .trailing)
        drawableText.draw(string: "Ingredients: ", font: 17, position: .onTheNextLine, alignment: .leading)

        let drawableCircle = DrawableCircle(paperSize: paperSize, context: context)
        
        drawableCircle.draw(color: .red)
        drawableCircle.addInnerText(string: "R", font: 17, alignment: .center, color: .label)

        drawableCircle.draw(color: .yellow)
        drawableCircle.addInnerText(string: "S", font: 17, alignment: .center, color: .blue)

        drawableCircle.draw(color: .blue)
        drawableCircle.addInnerText(string: "E", font: 17, alignment: .center, color: .yellow)

        let drawableImage = DrawableImage(paperSize: paperSize, context: context)
        
        drawableImage.draw(image: UIImage(named: "Toast")!, alignment: .trailing)
    }
}

extension String {
    static let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam venenatis a tortor sed mattis. Mauris finibus feugiat eros, id accumsan eros viverra id. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Duis gravida quam ligula, sit amet pharetra dolor accumsan vel. Nulla sit amet erat luctus, mollis ex in, interdum augue. Sed scelerisque libero quis nunc maximus scelerisque. Fusce rutrum justo elit. Donec mattis pulvinar velit, hendrerit placerat ipsum elementum sit amet. Phasellus et bibendum felis. Vivamus ac orci dapibus metus fringilla auctor. Nullam ullamcorper sem vitae urna dignissim tristique. Nullam finibus in augue vitae ornare."
}
