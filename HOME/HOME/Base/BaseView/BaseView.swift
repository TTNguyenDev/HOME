//
//  BaseView.swift
//  HOME
//
//  Created by TT Nguyen on 1/21/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }
    
    fileprivate func didInit() {
        self.backgroundColor = #colorLiteral(red: 0.9350267053, green: 0.9459032416, blue: 0.9692602754, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 20
    }
    
}


