//
//  SecondaryViewController.swift
//  TakeMyMoney
//
//  Created by chris on 11/4/20.
//

import UIKit

class SecondaryViewController: UIViewController {

    @IBOutlet weak var PaymentInfoView: UIView!
    @IBOutlet weak var PayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PaymentInfoView.layer.cornerRadius = 8
        PayButton.layer.cornerRadius = 26
    }
    

}
