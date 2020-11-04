//
//  SecondaryViewController.swift
//  TakeMyMoney
//
//  Created by chris on 11/4/20.
//

import UIKit

class SecondaryViewController: UIViewController {

    @IBOutlet weak var PaymentInfoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PaymentInfoView.layer.cornerRadius = 8
    }
    

}
