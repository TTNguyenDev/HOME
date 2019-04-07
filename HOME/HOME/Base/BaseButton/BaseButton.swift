//
//  BaseButton.swift
//  HOME
//
//  Created by TT Nguyen on 1/21/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }
    
    fileprivate func didInit() {
        self.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.4, blue: 0.7254901961, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 10
    }
}
