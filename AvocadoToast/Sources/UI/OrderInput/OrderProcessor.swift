//
//  OrderProcessor.swift
//  AvocadoToast
//
//  Created by Alex Zaharia on 06/03/2020.
//  Copyright © 2020 BEILMO. All rights reserved.
//

import Foundation

protocol OrderProcessor {
    func process(_ order: Order)
}
