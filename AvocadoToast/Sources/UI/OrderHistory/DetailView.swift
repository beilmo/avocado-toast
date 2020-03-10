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
    
    var body: some View {
        VStack {
            OrderRow(presenter: presenter)
                .padding()
            AvocadoToastView(order: .constant(presenter.order))
                .disabled(true)
            Spacer()
            Button(action: { self.isPreviewPresented.toggle() }, label: {
                Text("Preview PDF")
            }).sheet(isPresented: $isPreviewPresented) {
                PDFReaderView(presenter: self.presenter)
            }
            Spacer()
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(presenter: OrderPresenter(order: History().orders.first!))
    }
}
