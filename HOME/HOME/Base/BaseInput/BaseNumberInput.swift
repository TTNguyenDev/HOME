//
//  BaseTextInput.swift
//  HOME
//
//  Created by TT Nguyen on 1/21/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

class BaseNumberInput: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }
    
    fileprivate func didInit() {
        
        placeholder = "Enter Value Of This Month"
        keyboardType = .numberPad
        clearButtonMode = .whileEditing
    }
    
}



