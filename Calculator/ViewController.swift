//
//  ViewController.swift
//  Calculator
//
//  Created by Yanni Speron on 9/1/20.
//  Copyright © 2020 YanniSperon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var finalAmountLabel: UILabel!
    @IBOutlet weak var customTipTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.placeholder = Locale.current.currencySymbol
        
        customTipTextField.isHidden = false
        customTipTextField.alpha = 0.0
        
        let fmt = NumberFormatter()
        fmt.allowsFloats = true
        fmt.minimumFractionDigits = 2
        fmt.maximumFractionDigits = 2
        fmt.minimumIntegerDigits = 1
        fmt.roundingMode = .up
        fmt.numberStyle = .currency
        
        tipAmountSegmentedControl.setTitle(String(format: "%.2f", UserDefaults.standard.double(forKey: "option1") * 100.0).replacingOccurrences(of: ".", with: String(Locale.current.decimalSeparator ?? ".")), forSegmentAt: 0)
        tipAmountSegmentedControl.setTitle(String(format: "%.2f", UserDefaults.standard.double(forKey: "option2") * 100.0).replacingOccurrences(of: ".", with: String(Locale.current.decimalSeparator ?? ".")), forSegmentAt: 1)
        tipAmountSegmentedControl.setTitle(String(format: "%.2f", UserDefaults.standard.double(forKey: "option3") * 100.0).replacingOccurrences(of: ".", with: String(Locale.current.decimalSeparator ?? ".")), forSegmentAt: 2)
        
        if ((NSDate().timeIntervalSince1970 - UserDefaults.standard.double(forKey: "time")) <= 600) {
            let billAmount = UserDefaults.standard.double(forKey: "billAmount")
            let finalAmount = UserDefaults.standard.double(forKey: "finalAmount")
            let tipAmount = UserDefaults.standard.double(forKey: "tipAmount")
            let selectedIndex = UserDefaults.standard.integer(forKey: "selectedTipAmount")
            let customTipValue = UserDefaults.standard.double(forKey: "customTipValue")
            
            billAmountTextField.text = String(billAmount).replacingOccurrences(of: ".", with: String(Locale.current.decimalSeparator ?? "."))
            tipAmountLabel.text = fmt.string(from: NSNumber(value: tipAmount)) ?? fmt.string(from: 0.0)
            
            finalAmountLabel.text = fmt.string(from: NSNumber(value: finalAmount)) ?? fmt.string(from: 0.0)
            
            customTipTextField.text = String(customTipValue)
            tipAmountSegmentedControl.selectedSegmentIndex = selectedIndex
            
            if (selectedIndex == 3) {
                customTipTextField.alpha = 1.0
            }
        } else {
            tipAmountLabel.text = fmt.string(from: 0.0)
            finalAmountLabel.text = fmt.string(from: 0.0)
            
            tipAmountSegmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "defaultTipOption")
        }
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func customTipAmountChanged(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func billAmountFieldChanged(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func tipAmountControlChanged(_ sender: Any) {
        if (tipAmountSegmentedControl.selectedSegmentIndex == 3) {
            UIView.animate(withDuration: 0.25) {
                self.customTipTextField.alpha = 1.0
            }
            customTipTextField.becomeFirstResponder()
        } else {
            UIView.animate(withDuration: 0.25) {
                self.customTipTextField.alpha = 0.0
            }
            view.endEditing(true)
        }
        calculateTip()
    }
    
    private func calculateTip() {
        var billAmount = 0.0
        if let unwrappedValue = billAmountTextField.text {
            billAmount = Double(unwrappedValue.replacingOccurrences(of: String(Locale.current.decimalSeparator ?? "."), with: ".")) ?? 0.0
        }
        
        var customTipValue = 0.0
        if let unwrappedValue = customTipTextField.text {
            customTipValue = Double(unwrappedValue.replacingOccurrences(of: String(Locale.current.decimalSeparator ?? "."), with: ".")) ?? 0.0
        }
        
        let opt1 = UserDefaults.standard.double(forKey: "option1")
        let opt2 = UserDefaults.standard.double(forKey: "option2")
        let opt3 = UserDefaults.standard.double(forKey: "option3")
        
        let tipValues = [opt1, opt2, opt3, customTipValue / 100.0]
        
        let tipPercentage = tipValues[tipAmountSegmentedControl.selectedSegmentIndex]
        
        let fmt = NumberFormatter()
        fmt.allowsFloats = true
        fmt.minimumFractionDigits = 2
        fmt.maximumFractionDigits = 2
        fmt.minimumIntegerDigits = 1
        fmt.roundingMode = .up
        fmt.numberStyle = .currency
        
        let tipAmount = tipPercentage * billAmount
        tipAmountLabel.text = fmt.string(from: NSNumber(value: tipAmount)) ?? fmt.string(from: 0.0)
        
        let finalAmount = tipAmount + billAmount
        finalAmountLabel.text = fmt.string(from: NSNumber(value: finalAmount)) ?? fmt.string(from: 0.0)
        
        UserDefaults.standard.set(billAmount, forKey: "billAmount")
        UserDefaults.standard.set(finalAmount, forKey: "finalAmount")
        UserDefaults.standard.set(tipAmount, forKey: "tipAmount")
        UserDefaults.standard.set(tipAmountSegmentedControl.selectedSegmentIndex, forKey: "selectedTipAmount")
        UserDefaults.standard.set(customTipValue, forKey: "customTipValue")
        
        UserDefaults.standard.set(NSDate().timeIntervalSince1970, forKey: "time")
    }
}

