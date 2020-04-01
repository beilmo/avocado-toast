//
//  DetailView.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 04/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let presenter: OrderPresenter
    @State private var isPreviewPresented: Bool = false
    @State private var isActivityVCPresented: Bool = false
    @State private var isSheetPresented: Bool = false
    
    var body: some View {
        VStack {
            OrderRow(presenter: presenter)
                .padding()
            AvocadoToastView(order: .constant(presenter.order))
                .disabled(true)
            Spacer()
            Button(action: presentPDFPreview, label: {
                Text("Preview PDF")
            })
            Spacer()
        }
        .navigationBarTitle("Order Preview", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: presentActivityVC) {
            Image(systemName: "square.and.arrow.up")
        })
        .sheet(isPresented: $isSheetPresented, onDismiss: stopPresenting) {
            if self.isPreviewPresented {
                PDFOrderPreviewView(presenter: self.presenter)
            } else {
                if self.isActivityVCPresented {
                    ShareViewController(pdfData: PDFCreator(paperSize: .A4, presenter: self.presenter).create())
                }
            }
        }
    }

    func presentPDFPreview() {
        isSheetPresented.toggle()
        isPreviewPresented.toggle()
    }

    func presentActivityVC() {
        isSheetPresented.toggle()
        isActivityVCPresented.toggle()
    }

    func stopPresenting() {
        if isPreviewPresented {
            isPreviewPresented.toggle()
        }
        if isActivityVCPresented {
            isActivityVCPresented.toggle()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(presenter: OrderPresenter(order: History().orders.first!))
    }
}
