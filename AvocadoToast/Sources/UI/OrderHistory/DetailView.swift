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
    
    var body: some View {
        VStack {
            OrderRow(presenter: presenter)
                .padding()
            AvocadoToastView(order: .constant(presenter.order))
                .disabled(true)
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
