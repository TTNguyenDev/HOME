//
//  BaseTextInput.swift
//  HOME
//
//  Created by Trọng Tín on 17/02/2021.
//  Copyright © 2021 TT Nguyen. All rights reserved.
//

import UIKit

class BaseTextInput: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }
    
    fileprivate func didInit() {
        clearButtonMode = .whileEditing
        placeholder = "Let input"
    }
    
}
