//
//  InputPageViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/20/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

class InputPageViewController: BaseViewController {
    
    //Phòng 1.1
    @IBOutlet var mElec_1_1: BaseTextInput!
    @IBOutlet var mWater_1_1: BaseTextInput!
    
    //Phòng 3.1
    @IBOutlet var mElec_3_1: BaseTextInput!
    @IBOutlet var mWater_3_1: BaseTextInput!
    
    //Phòng 1.2
    @IBOutlet var mElec_1_2: BaseTextInput!
    @IBOutlet var mWater_1_2: BaseTextInput!
    
    //Phòng 2.2
    @IBOutlet var mElec_2_2: BaseTextInput!
    @IBOutlet var mWater_2_2: BaseTextInput!
    
    //Phòng 3.2
    @IBOutlet var mElec_3_2: BaseTextInput!
    @IBOutlet var mWater_3_2: BaseTextInput!
    
    //Phòng 4.2
    @IBOutlet var mElec_4_2: BaseTextInput!
    @IBOutlet var mWater_4_2: BaseTextInput!
    
    
    @IBOutlet var mShowInputUser: UIButton!
    @IBOutlet var mainStack: UIStackView!
    @IBOutlet var stack: UIStackView!
    
    @IBAction func saveButton(_ sender: Any) {
       
        
    }
    
    @IBAction func showInputUser(_ sender: Any) {
        if stack.isHidden {
            mShowInputUser.setImage(UIImage(named: "hide"), for: .normal)
        } else {
            mShowInputUser.setImage(UIImage(named: "show"), for: .normal)
        }
        
        self.stack.isHidden = !self.stack.isHidden
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .showHideTransitionViews, animations: {
            self.mainStack.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
}

extension InputPageViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputPageViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
