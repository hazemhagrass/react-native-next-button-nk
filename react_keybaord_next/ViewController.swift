//
//  ViewController.swift
//  react_keybaord_next
//
//  Created by Mohannad A. Hassan on 7/12/17.
//  Copyright © 2017 Mohannad A. Hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var kub: KeyboardUtilityBar!
    
    @IBOutlet weak var numericalTextField: UITextField!
    @IBOutlet weak var textOnlyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.kub = KeyboardUtilityBar(nextCallBack: self.showNextKeyboard, cancelCalllBack: self.dismissKeyboard)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
        // Dispose of any resources that can be recreated.
    }

    func dismissKeyboard() {
        self.numericalTextField.resignFirstResponder()
        self.textOnlyTextField.resignFirstResponder()
    }
    
    func showNextKeyboard() {
        if self.numericalTextField.isFirstResponder {
            self.textOnlyTextField.becomeFirstResponder()
        }
        else {
            self.numericalTextField.becomeFirstResponder()
        }
    }
}

