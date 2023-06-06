//
//  ViewController.swift
//  PaymentApp-CIBL-Task
//
//  Created by Md Hosne Mobarok on 6/6/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Button Actions -
    @IBAction func payWithBkashButtonAction(_ sender: UIButton) {
        loadVC(paymentMethod: .bKash)
    }
    
    @IBAction func payWithNagadButtonAction(_ sender: UIButton) {
        loadVC(paymentMethod: .Nagad)
    }
    
    //MARK: - Private Methods -
    func loadVC(paymentMethod: PaymentMethod){
        if let paymentVC = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController{
            paymentVC.paymentMethod = paymentMethod
            self.navigationController?.pushViewController(paymentVC, animated: true)
        }
    }
}

