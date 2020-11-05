//
//  ViewController.swift
//  TakeMyMoney
//
//  Created by chris on 11/3/20.
//

import UIKit
import WebKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    func isValid(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
    
    @IBOutlet weak var CreditButton: UIButton!
    @IBOutlet var PayPalButton: UIButton!
    @IBOutlet weak var ProceedConfirmButton: UIButton!
    @IBOutlet weak var CreditView: UIView!
    @IBOutlet weak var PayPalView: UIView!
    @IBOutlet weak var cardNumberTextInput: UITextField!
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var CVVTextField: UITextField!
    @IBOutlet weak var cardholderNameTextField: UITextField!
    @IBOutlet weak var invalidCardNumberLabel: UILabel!
    @IBOutlet weak var invalidDateLabel: UILabel!
    @IBOutlet weak var invalidCVVLabel: UILabel!
    @IBOutlet weak var invalidFullNameLabel: UILabel!
    @IBOutlet weak var invalidPaypalPasswordLabel: UILabel!
    @IBOutlet weak var invalidPayPalEmailLebel: UILabel!
    @IBOutlet weak var PaypalUserNameTextField: UITextField!
    @IBOutlet weak var PaypalPasswordTextField: UITextField!
    
    var datePicker: UIDatePicker?
    
    var temp = ""
    var isFormError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondaryVC = segue.destination as? SecondaryViewController {
            secondaryVC.paymentType = CreditButton.isSelected ? .credit : .paypal
            secondaryVC.payPalAccountEmail = PaypalUserNameTextField.text!
            secondaryVC.creditCardNumber = cardNumberTextInput.text!
        }
    }
    
    func isPaypalFormValid(textField: UITextField) -> Bool {
        var result = true
        switch textField {
            case PaypalUserNameTextField:
                print("PaypalUserNameTextField")
                invalidPayPalEmailLebel.isHidden = true
                print(isValid(YourEMailAddress: PaypalUserNameTextField.text!))
                if !isValid(YourEMailAddress: PaypalUserNameTextField.text!) {
                    print("not valid!!!")
                    PaypalUserNameTextField.layer.borderWidth = 2.0
                    PaypalUserNameTextField.layer.borderColor = UIColor.red.cgColor
                    invalidPayPalEmailLebel.isHidden = false
                    result = false
                }
            case PaypalPasswordTextField:
                print("PaypalPasswordTextField")
                invalidPaypalPasswordLabel.isHidden = true
                if PaypalPasswordTextField.text == "" {
                    PaypalPasswordTextField.layer.borderWidth = 2.0
                    PaypalPasswordTextField.layer.borderColor = UIColor.red.cgColor
                    invalidPaypalPasswordLabel.isHidden = false
                    result = false
                }
            default:
                print("default")
        }
        return result
    }
    
    func isCreditFormFieldValid(textField: UITextField) -> Bool {
        var result = true
        switch textField {
            case cardNumberTextInput:
                invalidCardNumberLabel.isHidden = true
                if cardNumberTextInput.text!.count < 19 {
                    cardNumberTextInput.layer.borderWidth = 2.0
                    cardNumberTextInput.layer.borderColor = UIColor.red.cgColor
                    invalidCardNumberLabel.isHidden = false
                    result = false
                }
            case datePickerTextField:
                invalidDateLabel.isHidden = true
                if datePickerTextField.text == "" {
                    datePickerTextField.layer.borderWidth = 2.0
                    datePickerTextField.layer.borderColor = UIColor.red.cgColor
                    invalidDateLabel.isHidden = false
                    result = false
                }
            case CVVTextField:
                invalidCVVLabel.isHidden = true
                if CVVTextField.text!.count < 3 {
                    CVVTextField.layer.borderWidth = 2.0
                    CVVTextField.layer.borderColor = UIColor.red.cgColor
                    invalidCVVLabel.isHidden = false
                    result = false
                }
            case cardholderNameTextField:
                invalidFullNameLabel.isHidden = true
                let fullNameArray = cardholderNameTextField.text?.split(separator: " ")
                if cardholderNameTextField.text == "" || fullNameArray!.count < 2 {
                    cardholderNameTextField.layer.borderWidth = 2.0
                    cardholderNameTextField.layer.borderColor = UIColor.red.cgColor
                    invalidFullNameLabel.isHidden = false
                    result = false
                }
            default:
                print("default")
        }
        print("result as of now is: \(result)")
        return result
    }
    
    @IBAction func ProceedBtnPressed(_ sender: UIButton) {
        var result = true
        if CreditButton.isSelected {
            let arrayOfCreditTextFields = [cardNumberTextInput, datePickerTextField, CVVTextField, cardholderNameTextField]
            for textField in arrayOfCreditTextFields {
                if !isCreditFormFieldValid(textField: textField!) {
                    result = false
                }
            }
        } else {
            let arrayOfPaypalTextFields = [PaypalUserNameTextField, PaypalPasswordTextField]
            for textField in arrayOfPaypalTextFields {
                if !isPaypalFormValid(textField: textField!) {
                    result = false
                }
            }
        }
        if result == true {
            performSegue(withIdentifier: "PaymentScreenSegue", sender: nil)
        }
    }
    
    func configureUI() {
        invalidCardNumberLabel.isHidden = true
        invalidDateLabel.isHidden = true
        invalidCVVLabel.isHidden = true
        invalidFullNameLabel.isHidden = true
        invalidPayPalEmailLebel.isHidden = true
        invalidPaypalPasswordLabel.isHidden = true
        cardNumberTextInput.delegate = self
        CVVTextField.delegate = self
        cardholderNameTextField.delegate = self
        PaypalUserNameTextField.delegate = self
        PaypalPasswordTextField.delegate = self
        self.cardNumberTextInput.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        self.CVVTextField.addTarget(self, action: #selector(didChangeCVVText(textField:)), for: .editingChanged)
        self.cardholderNameTextField.addTarget(self, action: #selector(didChangeCardHolderText(textField:)), for: .editingChanged)
        self.PaypalUserNameTextField.addTarget(self, action: #selector(didChangePayPalUserName(textField:)), for: .editingChanged)
        self.PaypalPasswordTextField.addTarget(self, action: #selector(didChangePayPalPassword(textField:)), for: .editingChanged)
        configureButtonUI()
        configureDatePicker()
        PayPalView.isHidden = true
        CreditButtonPressed(CreditButton)
//        CreditButton.isEnabled = false
//        PayPalButton.isEnabled = true
//        CreditButton.alpha = 0.4
        cardNumberTextInput.setLeftPaddingPoints(104)
    }
    
    func configureButtonUI () {
        PayPalButton.imageView?.contentMode = .scaleAspectFit
        PayPalButton.layer.cornerRadius = 10
        CreditButton.imageView?.contentMode = .scaleAspectFit
        CreditButton.layer.cornerRadius = 10
        ProceedConfirmButton.layer.cornerRadius = 26
    }
    
    func configureDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        datePickerTextField.inputView = datePicker
    }
    
    @objc func dateChanged(datePicker:UIDatePicker) {
        let result = isCreditFormFieldValid(textField: datePickerTextField)
        if result {   
            datePickerTextField.layer.borderWidth = 0
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        datePickerTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func viewTapped(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func onClickDoneButton() {
        self.view.endEditing(true)
    }
    
    @objc func didChangeText(textField:UITextField) {
        textField.text = self.modifyCreditCardString(creditCardString: textField.text!)
    }
    
    @objc func didChangeCVVText(textField:UITextField) {
        let result = isCreditFormFieldValid(textField: CVVTextField)
        if result {
            CVVTextField.layer.borderWidth = 0
        }
    }
    
    @objc func didChangeCardHolderText(textField:UITextField) {
        let result = isCreditFormFieldValid(textField: cardholderNameTextField)
        if result {
            cardholderNameTextField.layer.borderWidth = 0
        }
    }
    
    @objc func didChangePayPalUserName(textField:UITextField) {
        let result = isPaypalFormValid(textField: PaypalUserNameTextField)
        if result {
            PaypalUserNameTextField.layer.borderWidth = 0
        }
    }
    
    @objc func didChangePayPalPassword(textField:UITextField) {
        let result = isPaypalFormValid(textField: PaypalPasswordTextField)
        if result {
            PaypalPasswordTextField.layer.borderWidth = 0
        }
    }
    
    func modifyCreditCardString(creditCardString : String) -> String {
        if isCreditFormFieldValid(textField: cardNumberTextInput) {
            cardNumberTextInput.layer.borderWidth = 0
        }
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
        // clear Paypal form
        //configureUI()
        CreditView.isHidden = true
        PayPalView.isHidden = false
        PayPalButton.isSelected = true
        CreditButton.isSelected = false
        PayPalButton.isEnabled = false
        CreditButton.isEnabled = true
        PayPalButton.alpha = 0.4
        CreditButton.alpha = 1
    }
    
    @IBAction func CreditButtonPressed(_ sender: UIButton) {
        // clear credit form
        //configureUI()
        CreditView.isHidden = false
        PayPalView.isHidden = true
        CreditButton.isSelected = true
        PayPalButton.isSelected = false
        CreditButton.isEnabled = false
        PayPalButton.isEnabled = true
        CreditButton.alpha = 0.4
        PayPalButton.alpha = 1
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           moveTextField(textField, moveDistance: -170, up: true)
       }

       func textFieldDidEndEditing(_ textField: UITextField) {
           moveTextField(textField, moveDistance: -170, up: false)
       }

       // Hide the keyboard when the return key pressed
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }


       func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
           let moveDuration = 0.3
           let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)

           UIView.beginAnimations("cardholderNameTextField", context: nil)
           UIView.setAnimationBeginsFromCurrentState(true)
           UIView.setAnimationDuration(moveDuration)
           self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
           UIView.commitAnimations()
       }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        switch textField {
            case cardholderNameTextField:
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                let Regex = "[a-z A-Z ]+"
                    let predicate = NSPredicate.init(format: "SELF MATCHES %@", Regex)
                    if predicate.evaluate(with: text) || string == ""
                    {
                        result = true
                    }
                    else
                    {
                        result = false
                    }
        case PaypalUserNameTextField, PaypalPasswordTextField:
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let maxLength = 35
            result = updatedString.count <= maxLength
        case cardNumberTextInput, CVVTextField:
            let allowedCharacters = "+1234567890"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let MAX_LENGTH = textField == cardNumberTextInput ? 19 : 3
            let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            result = allowedCharacterSet.isSuperset(of: typedCharacterSet) && updatedString.count <= MAX_LENGTH
        default:
            print("default case")
        }
        return result
    }
}

extension String {
    var wordList: [String] {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }
}

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
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



