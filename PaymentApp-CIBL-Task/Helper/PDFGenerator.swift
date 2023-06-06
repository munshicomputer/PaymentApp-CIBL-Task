//
//  Helper.swift
//  PaymentApp-CIBL-Task
//
//  Created by Md Hosne Mobarok on 6/6/23.
//

import CoreLocation
import UIKit
import PDFKit

class PDFGenerator{

    let paymentInfo: PaymentInfo
    var paymentGateWayLogo: UIImage
    
    init(paymentInfo: PaymentInfo) {
        self.paymentInfo = paymentInfo
        if paymentInfo.paymentMethod == .bKash{
            paymentGateWayLogo = UIImage(named: "bkash_money_send_icon")!
        }else{
            paymentGateWayLogo = UIImage(named: "ic_nagad")!
        }
    }
    
    func generatePDFRecept()-> Data{
        let pageSize = CGSize(width: 390, height: 636)
        let randerer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
        let data = randerer.pdfData { context in
            context.beginPage()
            
            let centerParagraphStyle = NSMutableParagraphStyle()
            centerParagraphStyle.alignment = .center
            let leftParagraphStyle = NSMutableParagraphStyle()
            leftParagraphStyle.alignment = .left
            let rightParagraphStyle = NSMutableParagraphStyle()
            rightParagraphStyle.alignment = .right
            
            paymentGateWayLogo.draw(in: CGRect(x: 32, y: 48, width: 90, height: 40))//set payment gateway logo
            
            //set bank logo
            UIImage(named: "cbbl_full_logo")!.draw(in: CGRect(x: 250, y: 69, width: 108, height: 37))
            
            // set payment gatway fund tranfer text
            let textRect = CGRect(x: 33, y: 112, width: pageSize.width / 2, height: 12)
            let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 9), .foregroundColor : UIColor.lightGray]
            let text = "\(paymentInfo.paymentMethod.rawValue) Fund Transfer"
            let attributedText = NSAttributedString(string: text, attributes: textAttributes)
            attributedText.draw(in: textRect)
            
            //Set bank address text
            let bankAddressText = NSMutableAttributedString(attributedString:  NSAttributedString(string: "\(paymentInfo.currentAddress)", attributes: [.font: UIFont.systemFont(ofSize: 9), .foregroundColor : UIColor.lightGray]))
            bankAddressText.addAttribute(.paragraphStyle, value: rightParagraphStyle, range: NSMakeRange(0, bankAddressText.length))
            bankAddressText.draw(with: CGRect(x: 211, y: 112, width: 147, height: 22), options: .usesLineFragmentOrigin, context: nil)
            
            //Cash transection Recept Text set
            let transectionReceptHeding = NSMutableAttributedString(attributedString: NSAttributedString(string: "COMMUNITY CASH TRANSACTION RECEIPT", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor : UIColor.black]))
            transectionReceptHeding.addAttribute(.paragraphStyle, value: centerParagraphStyle, range: NSMakeRange(0, transectionReceptHeding.length))
            transectionReceptHeding.draw(in: CGRect(x: 126, y: 165, width: 138, height: 30))
            
            //Set Recept Header Bacground
            UIImage(named: "ReciptBacGround")!.draw(in: CGRect(x: 32, y: 215, width: 326, height: 20))
            
            //set source account card text
            NSAttributedString(string: "Source Account/Card", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.black]).draw(in: CGRect(x: 36, y: 219, width: (pageSize.width / 2) - 36, height: 13))
        
            //set card number
            NSAttributedString(string: "0010300004201", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.black]).draw(in: CGRect(x: 280, y: 219, width: (pageSize.width / 2), height: 13))
            
            //set ammount label
            NSAttributedString(string: "Amount", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]).draw(in: CGRect(x: 36, y: 239, width: (pageSize.width / 2), height: 13))
            
            //set ammount balace
            let amountBalanceText = NSMutableAttributedString(attributedString:  NSAttributedString(string: "BDT \(String(format: "%.2f", paymentInfo.paymentAmount))", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]))
            amountBalanceText.addAttribute(.paragraphStyle, value: rightParagraphStyle, range: NSMakeRange(0, amountBalanceText.length))
            amountBalanceText.draw(with: CGRect(x: (pageSize.width / 2) - 36, y: 239, width: (pageSize.width / 2), height: 13), options: .usesLineFragmentOrigin, context: nil)
            
            //set transectionDateTime label
            NSAttributedString(string: "Transaction Date Time", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]).draw(in: CGRect(x: 36, y: 258, width: (pageSize.width / 2), height: 13))
            
            //set Transection Date time
            let transectionDateText = NSMutableAttributedString(attributedString:  NSAttributedString(string: paymentInfo.paymentDate.formattedString(), attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]))
            transectionDateText.addAttribute(.paragraphStyle, value: rightParagraphStyle, range: NSMakeRange(0, transectionDateText.length))
            transectionDateText.draw(with: CGRect(x: (pageSize.width / 2) - 36, y: 258, width: (pageSize.width / 2), height: 13), options: .usesLineFragmentOrigin, context: nil)
            
            
            //set Narration label
            NSAttributedString(string: "Narration", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]).draw(in: CGRect(x: 36, y: 277, width: (pageSize.width / 2), height: 13))
            
            //set Narration text time
            let narrationText = NSMutableAttributedString(attributedString:  NSAttributedString(string: paymentInfo.narration, attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]))
            narrationText.addAttribute(.paragraphStyle, value: rightParagraphStyle, range: NSMakeRange(0, narrationText.length))
            narrationText.draw(with: CGRect(x: (pageSize.width / 2) - 36, y: 277, width: (pageSize.width / 2), height: 13), options: .usesLineFragmentOrigin, context: nil)
            
            //Set Recept Header Bacground
            UIImage(named: "ReciptBacGround")!.draw(in: CGRect(x: 32, y: 308, width: 326, height: 20))
            
            //set source account card text
            NSAttributedString(string: "Transection Info", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.black]).draw(in: CGRect(x: 36, y: 312, width: (pageSize.width / 2) - 36, height: 13))
        
            //set paymentNumber label
            NSAttributedString(string: "\(paymentInfo.paymentMethod.rawValue) Number ", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]).draw(in: CGRect(x: 36, y: 332, width: (pageSize.width / 2), height: 13))
            
            //set paymentNumber balace
            let paymentNumberText = NSMutableAttributedString(attributedString:  NSAttributedString(string: " \(paymentInfo.paymentNumber)", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]))
            paymentNumberText.addAttribute(.paragraphStyle, value: rightParagraphStyle, range: NSMakeRange(0, paymentNumberText.length))
            paymentNumberText.draw(with: CGRect(x: (pageSize.width / 2) - 36, y: 332, width: (pageSize.width / 2), height: 13), options: .usesLineFragmentOrigin, context: nil)
            
            //set reference label
            NSAttributedString(string: "Reference No", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]).draw(in: CGRect(x: 36, y: 351, width: (pageSize.width / 2), height: 13))
            
            //set reference Text
            let referenceText = NSMutableAttributedString(attributedString:  NSAttributedString(string: "TXN13801", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]))
            referenceText.addAttribute(.paragraphStyle, value: rightParagraphStyle, range: NSMakeRange(0, referenceText.length))
            referenceText.draw(with: CGRect(x: (pageSize.width / 2) - 36, y: 351, width: (pageSize.width / 2), height: 13), options: .usesLineFragmentOrigin, context: nil)
            
            //set border line image
            UIImage(named: "border")!.draw(in: CGRect(x: 33, y: 368, width: 325, height: 1))
            
            //set totalammount label
            NSAttributedString(string: "Total", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]).draw(in: CGRect(x: 36, y: 371, width: (pageSize.width / 2), height: 13))
            
            //set ammount balace
            let totalAmountText = NSMutableAttributedString(attributedString:  NSAttributedString(string: "BDT \(String(format: "%.2f", paymentInfo.paymentAmount))", attributes: [.font: UIFont.systemFont(ofSize: 8), .foregroundColor : UIColor.lightGray]))
            totalAmountText.addAttribute(.paragraphStyle, value: rightParagraphStyle, range: NSMakeRange(0, totalAmountText.length))
            totalAmountText.draw(with: CGRect(x: (pageSize.width / 2) - 36, y: 371, width: (pageSize.width / 2), height: 13), options: .usesLineFragmentOrigin, context: nil)
            
            //set success logo
            UIImage(named: "successseal")!.draw(in: CGRect(x: 250, y: 436, width: 108, height: 78))
            
        }
        return data
    }

}
