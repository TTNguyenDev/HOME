//
//  InputPageViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/20/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

class InputPageViewController: BaseViewController {
    
    
    
    @IBOutlet var mShowInputUser: UIButton!
    @IBAction func showInputUser(_ sender: Any) {
        if stack.isHidden {
            stack.isHidden = false
            mShowInputUser.setImage(UIImage(named: "hide"), for: .normal)
        } else {
            stack.isHidden = true
            mShowInputUser.setImage(UIImage(named: "show"), for: .normal)
        }
    }
    @IBOutlet var stack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
