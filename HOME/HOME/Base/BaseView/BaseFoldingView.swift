//
//  BaseFoldingView.swift
//  HOME
//
//  Created by TT Nguyen on 1/23/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import FoldingCell

class BaseFoldingView: RotatedView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }
    
    fileprivate func didInit() {
        self.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.968627451, alpha: 1)
    }
    

}
