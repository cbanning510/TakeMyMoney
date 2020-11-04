//
//  ViewController.swift
//  TakeMyMoney
//
//  Created by chris on 11/3/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CreditButton: UIButton!
    @IBOutlet var PayPalButton: UIButton!
    
    @IBOutlet weak var ProceedConfirmButton: UIButton!
    @IBOutlet weak var CreditView: UIView!
    @IBOutlet weak var PayPalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PayPalButton.imageView?.contentMode = .scaleAspectFit
        PayPalButton.layer.cornerRadius = 10
        CreditButton.imageView?.contentMode = .scaleAspectFit
        CreditButton.layer.cornerRadius = 10
        ProceedConfirmButton.layer.cornerRadius = 26
        PayPalView.isHidden = true
        CreditButton.isEnabled = false
        PayPalButton.isEnabled = true
        CreditButton.alpha = 0.4
    }
    
    @IBAction func PayPalButtonPressed(_ sender: UIButton) {
        CreditView.isHidden = true
        PayPalView.isHidden = false
        PayPalButton.isEnabled = false
        CreditButton.isEnabled = true
        PayPalButton.alpha = 0.4
        CreditButton.alpha = 1
    }
    
    @IBAction func ProceedBtnPressed(_ sender: UIButton) {
    }
    @IBAction func CreidtButtonPressed(_ sender: UIButton) {
        CreditView.isHidden = false
        PayPalView.isHidden = true
        CreditButton.isEnabled = false
        PayPalButton.isEnabled = true
        CreditButton.alpha = 0.4
        PayPalButton.alpha = 1
    }
}

