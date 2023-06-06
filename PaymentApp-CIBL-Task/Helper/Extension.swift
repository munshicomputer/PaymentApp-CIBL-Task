//
//  Extension.swift
//  PaymentApp-CIBL-Task
//
//  Created by Md Hosne Mobarok on 6/6/23.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
