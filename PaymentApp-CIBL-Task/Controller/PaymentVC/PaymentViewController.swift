//
//  PaymentViewController.swift
//  PaymentApp-CIBL-Task
//
//  Created by Md Hosne Mobarok on 6/6/23.
//

import UIKit
import CoreLocation

enum PaymentMethod: String{
    case bKash, Nagad
}

class PaymentViewController: UIViewController {
    
    //MARK: - Outlets -
    @IBOutlet weak var payWithLabel: UILabel!
    @IBOutlet weak var paymentNumberLable: UILabel!
    @IBOutlet weak var paymentNumberTextField: UITextField!
    @IBOutlet weak var paymentNameLabel: UILabel!
    @IBOutlet weak var paymentNameTextField: UITextField!
    @IBOutlet weak var paymentAmountTextField: UITextField!
    @IBOutlet weak var narrationTextField: UITextField!

    //MARK: - Instance member -
    var paymentMethod: PaymentMethod?
    var paymentInfo: PaymentInfo?
    var userLocationAddress: String?
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupPaymentContentView()
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Button Actions -
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if let paymentNumber = paymentNumberTextField.text, let paymentName = paymentNameTextField.text, let paymentAmount = paymentAmountTextField.text, let narrationText = narrationTextField.text{
            if !paymentNumber.isEmpty && !paymentName.isEmpty && !paymentAmount.isEmpty && !narrationText.isEmpty{
                paymentInfo = PaymentInfo(paymentMethod: paymentMethod ?? .bKash, paymentNumber: paymentNumber, paymentName: paymentName, paymentAmount: Double(paymentAmount) ?? 0.0, narration: narrationText, paymentDate: Date(), currentAddress: userLocationAddress ?? "Police Plaza Concord(Level 10,Tower 2) Plot 2,Road 144,Gulshan 1")
                let paymentDialog = PaymentReceiptViewController()
                paymentDialog.paymentInfo = paymentInfo
                paymentDialog.appear(sender: self)
            }
        }
    }
    
    //MARK: - Private Methods -
    func setupPaymentContentView(){
        if paymentMethod == .Nagad{
            payWithLabel.text = "Pay with Nagad"
            paymentNumberLable.text = "Nagad Number"
            paymentNumberTextField.placeholder = "Nagad Number"
            paymentNameLabel.text = "Nagad Name"
            paymentNameTextField.placeholder = "Nagad Name"
        }else {
            payWithLabel.text = "Pay with bKash"
            paymentNumberLable.text = "bKash Number"
            paymentNumberTextField.placeholder = "bKash Number"
            paymentNameLabel.text = "bKash Name"
            paymentNameTextField.placeholder = "bKash Name"
        }
    }
    
    //MARK: - Methods for get location -
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.startUpdatingLocation()
        
    }
}

//MARK: - get user current location deleget -
extension PaymentViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Reverse geocode the location
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed with error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                // Get the address information from the placemark
                let address = "\(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
                self.userLocationAddress = address
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
