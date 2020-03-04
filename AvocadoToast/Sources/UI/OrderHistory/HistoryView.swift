//
//  OrderHistoryView.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var history: History

    var presenters: [OrderPresenter] {
        history.orders
            .map(OrderPresenter.init(order:))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(presenters) { presenter in
                    NavigationLink(destination: DetailView(presenter: presenter)) {
                        OrderRow(presenter: presenter)
                    }
                }
                .onDelete { index in
                    self.history.remove(at: index)
                }
            }

            .navigationBarTitle("Order History")
            .navigationBarItems(leading: Button("Clear", action: history.clear),
                                trailing: EditButton())

        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: History())
    }
}
