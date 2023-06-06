//
//  File.swift
//  PaymentApp-CIBL-Task
//
//  Created by Md Hosne Mobarok on 6/6/23.
//

import Foundation

class PaymentInfo{
    let paymentMethod: PaymentMethod
    let paymentNumber: String
    let paymentName: String
    let paymentAmount: Double
    let narration: String
    let paymentDate: Date
    let currentAddress: String
    
    init(paymentMethod: PaymentMethod, paymentNumber: String, paymentName: String, paymentAmount: Double, narration: String, paymentDate: Date, currentAddress: String) {
        self.paymentMethod = paymentMethod
        self.paymentNumber = paymentNumber
        self.paymentName = paymentName
        self.paymentAmount = paymentAmount
        self.narration = narration
        self.paymentDate = paymentDate
        self.currentAddress = currentAddress
    }
    
}
