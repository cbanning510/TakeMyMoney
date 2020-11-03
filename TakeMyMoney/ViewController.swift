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
    
    @IBOutlet weak var CreditView: UIView!
    @IBOutlet weak var PayPalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PayPalButton.imageView?.contentMode = .scaleAspectFit
        PayPalButton.layer.cornerRadius = 10
        CreditButton.imageView?.contentMode = .scaleAspectFit
        CreditButton.layer.cornerRadius = 10
        //PayPalView.isHidden = true
    }
    
    @IBAction func PayPalButtonPressed(_ sender: UIButton) {
        CreditView.isHidden = true
        PayPalView.isHidden = false
    }
    
    @IBAction func CreidtButtonPressed(_ sender: UIButton) {
        CreditView.isHidden = false
        PayPalView.isHidden = true
    }
}

