//
//  PDFOrderPreviewView.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 12/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct PDFOrderPreviewView: View {
    let presenter: OrderPresenter
    @State private var isActivityVCPresented: Bool = false

    var body: some View {
        NavigationView {
            PDFReaderView(presenter: self.presenter)
                .navigationBarTitle("Order Preview", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { self.isActivityVCPresented.toggle() }) {
                    Image(systemName: "square.and.arrow.up")
                }
                .sheet(isPresented: $isActivityVCPresented, content: {
                    ShareViewController(pdfData: PDFCreator(paperSize: .A4, presenter: self.presenter).create())
                })
            )

        }
    }
}

struct PDFOrderPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PDFOrderPreviewView(presenter: OrderPresenter(order: History().orders.first!))
    }
}
