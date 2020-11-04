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
    
    var paymentType = PaymentType.paypal

    @IBOutlet weak var CreditInfoView: UIView!
    @IBOutlet weak var PayPalInfoView: UIView!
    @IBOutlet weak var PayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreditInfoView.layer.cornerRadius = 8
        PayPalInfoView.layer.cornerRadius = 8
        PayButton.layer.cornerRadius = 26
        if paymentType == PaymentType.credit {
            PayPalInfoView.isHidden = true
        } else {
            CreditInfoView.isHidden = true
        }
    }
    
    @IBAction func PayButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        CreditInfoView.isHidden = true
    }
    

}
