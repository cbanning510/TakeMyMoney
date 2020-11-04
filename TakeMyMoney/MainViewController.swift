//
//  ViewController.swift
//  TakeMyMoney
//
//  Created by chris on 11/3/20.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var CreditButton: UIButton!
    @IBOutlet var PayPalButton: UIButton!
    
    @IBOutlet weak var ProceedConfirmButton: UIButton!
    @IBOutlet weak var CreditView: UIView!
    @IBOutlet weak var PayPalView: UIView!
    @IBOutlet weak var cardNumberTextInput: UITextField!
    
    var temp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNumberTextInput.delegate = self
        
       self.cardNumberTextInput.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        
        PayPalButton.imageView?.contentMode = .scaleAspectFit
        PayPalButton.layer.cornerRadius = 10
        CreditButton.imageView?.contentMode = .scaleAspectFit
        CreditButton.layer.cornerRadius = 10
        ProceedConfirmButton.layer.cornerRadius = 26
        PayPalView.isHidden = true
        CreditButton.isEnabled = false
        PayPalButton.isEnabled = true
        CreditButton.alpha = 0.4
        cardNumberTextInput.setLeftPaddingPoints(104
        )
    }
    
    @objc func didChangeText(textField:UITextField) {
        textField.text = self.modifyCreditCardString(creditCardString: textField.text!)
    }
    

    func modifyCreditCardString(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        let arrOfCharacters = Array(trimmedString)
        var resultString = ""
        
        arrOfCharacters.enumerated().forEach { (index, character) in
            if index % 4 == 0 && index > 0 {
                resultString += " "
            }
            if index < 12 {
                resultString += "*"
            } else {
                resultString.append(character)
            }
        }
        return resultString
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "+1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        let MAX_LENGTH = 19
        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        return allowedCharacterSet.isSuperset(of: typedCharacterSet) && updatedString.count <= MAX_LENGTH

    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

