//
//  ContentView.swift
//  AvocadoToast
//
//  Created by Danciu Dorin-Bogdan on 29/02/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let history = History()

    var body: some View {
        TabView {
            OrderForm(history)
                .tabItem ({
                    HStack{
                        Image(systemName: "square.and.pencil")
                        Text("Order")
                    }
                })
            HistoryView(history: history)
                .tabItem({
                    HStack{
                        Image(systemName: "clock.fill")
                        Text("History")
                    }
                })
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
