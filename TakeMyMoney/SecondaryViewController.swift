//
//  SecondaryViewController.swift
//  TakeMyMoney
//
//  Created by chris on 11/4/20.
//

import UIKit

enum PaymentType {
    case credit
    case paypal
}

class SecondaryViewController: UIViewController {
    
    //var paymentType = PaymentType.credit
    var paymentType = PaymentType.paypal
    var payPalAccountEmail = ""
    var creditCardNumber = ""

    @IBOutlet weak var CreditInfoView: UIView!
    @IBOutlet weak var PayPalInfoView: UIView!
    @IBOutlet weak var PayButton: UIButton!
    @IBOutlet weak var creditCardNumberLabel: UILabel!
    @IBOutlet weak var paypalAccountEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardNumberLabel.text = "Master card ending in **\(creditCardNumber.suffix(2))"
        paypalAccountEmailLabel.text = payPalAccountEmail
        if paymentType == PaymentType.credit {
            PayPalInfoView.isHidden = true
        } else {
            CreditInfoView.isHidden = true
        }
    }
    
    func configureUI() {
        CreditInfoView.layer.cornerRadius = 8
        PayPalInfoView.layer.cornerRadius = 8
        PayButton.layer.cornerRadius = 26
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PayButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Denied", message: "Your payment has failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
