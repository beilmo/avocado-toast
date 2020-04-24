//
//  DrawableData.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 20/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import UIKit

class DrawableData {

    func render() {
        //paper size
        let paperSize: PaperSize = .A4

        //render elements
        renderElements(paperSize: paperSize)

        //finish rendering
        finishRendering()
    }

    func renderElements(paperSize: PaperSize) {
        //DrawableElements
        let drawableText = DrawableText()

        let drawableImage = DrawableImage()

        drawableImage.draw(image: UIImage(named: "Toast")!, alignment: .trailing)

        for index in 0...100 {
            print("index: ", index)
            drawableText.addText(string: String(index), font: 30, position: .onTheNextLine, alignment: .leading)
        }
        drawableText.addText(string: .loremIpsum, font: 20, position: .onTheNextLine, alignment: .leading)
        drawableText.addText(string: .loremIpsum2, font: 20, position: .onTheNextLine, alignment: .leading)
        drawableText.addText(string: .loremIpsum3, font: 20, position: .onTheNextLine, alignment: .leading)
        drawableText.addText(string: .loremIpsum3, font: 20, position: .onTheNextLine, alignment: .leading)
        drawableText.addText(string: .loremIpsum3, font: 20, position: .onTheNextLine, alignment: .leading)
        drawableText.addText(string: .loremIpsum3, font: 20, position: .onTheNextLine, alignment: .leading)

        drawableImage.draw(image: UIImage(named: "Toast")!, alignment: .center)

        drawableText.addText(string: .loremIpsum3, font: 20, position: .onTheNextLine, alignment: .leading)

        drawableImage.draw(image: UIImage(named: "Toast")!, alignment: .center)
        drawableImage.draw(image: UIImage(named: "Toast")!, alignment: .center)

        drawableText.addText(string: .loremIpsum3, font: 30, position: .onTheNextLine, alignment: .leading)

        drawableText.addText(string: "Ingredients: ", font: 20, position: .onTheNextLine, alignment: .leading)

        DrawableCircle()
            .color(.blue)
            .size(30)
            .addInnerText(string: "R", font: 20, alignment: .center, color: .white)

    }

    func finishRendering() {
        Coordinator.shared.clearCache()
    }
}

extension String {
    static let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam venenatis a tortor sed mattis. Mauris finibus feugiat eros, id accumsan eros viverra id. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Duis gravida quam ligula, sit amet pharetra dolor accumsan vel. Nulla sit amet erat luctus, mollis ex in, interdum augue. Sed scelerisque libero quis nunc maximus scelerisque. Fusce rutrum justo elit. Donec mattis pulvinar velit, hendrerit placerat ipsum elementum sit amet. Phasellus et bibendum felis. Vivamus ac orci dapibus metus fringilla auctor. Nullam ullamcorper sem vitae urna dignissim tristique. Nullam finibus in augue vitae ornare."
    static let loremIpsum2 = "Lorem pixum dolor sit amet, consectetur adipiscing elit. Aliquam venenatis a tortor sed mattis. Mauris finibus feugiat eros, id accumsan eros viverra id. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Duis gravida quam ligula, sit amet pharetra dolor accumsan vel. Nulla sit amet erat luctus, mollis ex in, interdum augue. Sed scelerisque libero quis nunc maximus scelerisque. Fusce rutrum justo elit. Donec mattis pulvinar velit, hendrerit placerat ipsum elementum sit amet. Phasellus et bibendum felis. Vivamus ac orci dapibus metus fringilla auctor. Nullam ullamcorper sem vitae urna dignissim tristique. Nullam finibus in augue vitae pulane."
    static let loremIpsum3 = "Lorem cucuruzum dolor sit amet, consectetur adipiscing elit. Aliquam venenatis a tortor sed mattis. Mauris finibus feugiat eros, id accumsan eros viverra id. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Duis gravida quam ligula, sit amet pharetra dolor accumsan vel. Nulla sit amet erat luctus, mollis ex in, interdum augue. Sed scelerisque libero quis nunc maximus scelerisque. Fusce rutrum justo elit. Donec mattis pulvinar velit, hendrerit placerat ipsum elementum sit amet. Phasellus et bibendum felis. Vivamus ac orci dapibus metus fringilla auctor. Nullam ullamcorper sem vitae urna dignissim tristique. Nullam finibus in augue vitae macarale."
}
