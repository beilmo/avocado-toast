//
//  ShareView.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 12/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import SwiftUI
import UIKit

struct ShareViewController: UIViewControllerRepresentable {
    let pdfData: Data

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityVC = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])

        return activityVC
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
