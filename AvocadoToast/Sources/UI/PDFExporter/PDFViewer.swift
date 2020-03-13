//
//  PDFViewer.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 10/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation
import SwiftUI
import PDFKit

struct PDFViewer: UIViewRepresentable {
    let presenter: OrderPresenter

    func makeUIView(context: Context) -> PDFView {
        // Create a PDF file
        let pdf = PDFCreator(paperSize: .A4, presenter: presenter)
        let data = pdf.create()

        // Create a `PDFView`
        let pdfView = PDFView()

        // Create a `PDFDocument` object and set it as `PDFView`'s document to load the document with data in that view.
        let pdfDocument = PDFDocument(data: data)
        pdfView.document = pdfDocument
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.autoScales = true
    }
}
