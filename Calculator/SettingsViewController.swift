//
//  SettingsViewController.swift
//  Calculator
//
//  Created by Yanni Speron on 9/14/20.
//  Copyright © 2020 YanniSperon. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var option1Percentage: UITextField!
    @IBOutlet weak var option2Percentage: UITextField!
    @IBOutlet weak var option3Percentage: UITextField!
    
    @IBOutlet weak var defaultTipSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (!UserDefaults.standard.bool(forKey: "hasLoaded")) {
            UserDefaults.standard.set(true, forKey: "hasLoaded")
            UserDefaults.standard.set(0.15, forKey: "option1")
            UserDefaults.standard.set(0.20, forKey: "option2")
            UserDefaults.standard.set(0.25, forKey: "option3")
        }
        
        let percFmt = NumberFormatter()
        percFmt.allowsFloats = true
        percFmt.minimumFractionDigits = 0
        percFmt.maximumFractionDigits = 2
        percFmt.minimumIntegerDigits = 1
        percFmt.roundingMode = .halfUp
        percFmt.numberStyle = .percent
        percFmt.multiplier = 1.0
        
        option1Percentage.text = percFmt.string(from: NSNumber(value: UserDefaults.standard.double(forKey: "option1") * 100.0)) ?? percFmt.string(from: 0.0)
        //option1Percentage.text = String(format: "%.2f", UserDefaults.standard.double(forKey: "option1") * 100.0).replacingOccurrences(of: ".", with: String(Locale.current.decimalSeparator ?? "."))
        option2Percentage.text = percFmt.string(from: NSNumber(value: UserDefaults.standard.double(forKey: "option2") * 100.0)) ?? percFmt.string(from: 0.0)
        //option2Percentage.text = String(format: "%.2f", UserDefaults.standard.double(forKey: "option2") * 100.0).replacingOccurrences(of: ".", with: String(Locale.current.decimalSeparator ?? "."))
        option3Percentage.text = percFmt.string(from: NSNumber(value: UserDefaults.standard.double(forKey: "option3") * 100.0)) ?? percFmt.string(from: 0.0)
        //option3Percentage.text = String(format: "%.2f", UserDefaults.standard.double(forKey: "option3") * 100.0).replacingOccurrences(of: ".", with: String(Locale.current.decimalSeparator ?? "."))
        
        defaultTipSegmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "defaultTipOption")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "update"), object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "update"), object: nil)
    }

    
    @IBAction func changedOption1(_ sender: Any) {
        var value = 15.0
        if let unwrappedText = option1Percentage.text {
            value = Double(unwrappedText.replacingOccurrences(of: String(Locale.current.decimalSeparator ?? "."), with: ".")) ?? 15.0
        }
        UserDefaults.standard.set(value / 100.0, forKey: "option1")
    }
    
    @IBAction func changedOption2(_ sender: Any) {
        var value = 20.0
        if let unwrappedText = option2Percentage.text {
            value = Double(unwrappedText.replacingOccurrences(of: String(Locale.current.decimalSeparator ?? "."), with: ".")) ?? 20.0
        }
        UserDefaults.standard.set(value / 100.0, forKey: "option2")
    }
    
    @IBAction func changedOption3(_ sender: Any) {
        var value = 25.0
        if let unwrappedText = option3Percentage.text {
            value = Double(unwrappedText.replacingOccurrences(of: String(Locale.current.decimalSeparator ?? "."), with: ".")) ?? 25.0
        }
        UserDefaults.standard.set(value / 100.0, forKey: "option3")
    }
    
    @IBAction func changedDefaultTip(_ sender: Any) {
        UserDefaults.standard.set(defaultTipSegmentedControl.selectedSegmentIndex, forKey: "defaultTipOption")
    }
}
