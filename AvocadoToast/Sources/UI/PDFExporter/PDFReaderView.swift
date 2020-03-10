//
//  PDFReaderView.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 10/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct PDFReaderView: View {
    let presenter: OrderPresenter

    var body: some View {
        PDFViewer(presenter: presenter)
    }
}

struct PDFReaderView_Previews: PreviewProvider {
    static var previews: some View {
        PDFReaderView(presenter: OrderPresenter(order: History().orders.first!))
    }
}
