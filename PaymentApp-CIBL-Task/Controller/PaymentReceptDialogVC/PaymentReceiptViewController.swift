//
//  PaymentReceptViewController.swift
//  PaymentApp-CIBL-Task
//
//  Created by Md Hosne Mobarok on 6/6/23.
//

import UIKit
import PDFKit
import CoreLocation

class PaymentReceiptViewController: UIViewController {
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var previewReciptView: PDFView!
    var paymentInfo: PaymentInfo?
    var pdfDocument = PDFDocument()
    var pdfData: Data?
    
    //MARK: - Make this view as Dialog View -
    init(){
        super.init(nibName: "PaymentReceptViewController", bundle: nil)
        super.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appear(sender: UIViewController){
        sender.present(self, animated: false) {
            UIView.animate(withDuration: 1, delay: 0.1) {
                self.backView.alpha = 1
                self.dialogView.alpha = 1
            }
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.dialogView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }

    }
    
    func configView(){
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.dialogView.alpha = 0
        dialogView.layer.cornerRadius = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Generate PDF and show in pdf view
        if let paymentInfo = self.paymentInfo{
            let pdfGenerator = PDFGenerator(paymentInfo: paymentInfo)
            pdfData = pdfGenerator.generatePDFRecept()
            guard let pdfData = pdfData else{return}
            pdfDocument = PDFDocument(data: pdfData) ?? PDFDocument()
            previewReciptView.document = pdfDocument
            previewReciptView.autoScales = true
        }
    }
    
    //MARK: - Button Action -
    @IBAction func closeButtonAction(_ sender: UIButton) {
        hide()
    }
    
    @IBAction func downloadPDFButtonAction(_ sender: UIButton) {
        guard let pdfData = pdfData else {return}
        savePDF(pdfData: pdfData) { tempURL in
            if let fileUrl = tempURL{
                let documentPicker = UIDocumentPickerViewController(forExporting: [fileUrl], asCopy: true)
                self.present(documentPicker, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func sharePDFButton(_ sender: UIButton) {

        guard let pdfData = previewReciptView.document?.dataRepresentation() else {
            print("Error getting PDF data.")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - Private Methods -
    
    func savePDF(pdfData: Data, complition: @escaping(URL?)->()){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("paymentReceipt.pdf")
            if FileManager.default.fileExists(atPath: fileURL.path){
                try FileManager.default.removeItem(at: fileURL)
            }
            try pdfData.write(to: fileURL)
            complition(fileURL)
            
            print("PDF file saved successfully at: \(fileURL)")
        } catch {
            print("Error saving PDF file: \(error.localizedDescription)")
        }
    }
}

