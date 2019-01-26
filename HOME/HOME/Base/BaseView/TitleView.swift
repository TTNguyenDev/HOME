//
//  TitleView.swift
//  HOME
//
//  Created by TT Nguyen on 1/21/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

class TitleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }
    
    fileprivate func didInit() {
        self.backgroundColor = #colorLiteral(red: 0.8083478808, green: 0.0325262323, blue: 0.3324780166, alpha: 1)
        self.clipsToBounds = true
        self.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.layer.cornerRadius = 5
    }
    
    

}
