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
        PDFReaderView(presenter: self.presenter)
    }
}

struct PDFOrderPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PDFOrderPreviewView(presenter: OrderPresenter(order: History().orders.first!))
    }
}
