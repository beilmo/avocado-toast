//
//  ContentView.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                OrderForm()
            }
            .tabItem ({
                HStack{
                    Image(systemName: "square.and.pencil")
                    Text("Order")
                }
            })
            OrderHistory(previousOrders: CompletedOrder.samples)
                .tabItem({
                    HStack{
                        Image(systemName: "clock.fill")
                        Text("History")
                    }
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
