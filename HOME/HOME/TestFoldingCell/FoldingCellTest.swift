//
//  FoldingCellTest.swift
//  HOME
//
//  Created by TT Nguyen on 1/22/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import FoldingCell

class FoldingCellTest: FoldingCell {

    
    var number: Int = 0 {
        didSet {
           
        }
    }
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:FoldingCell.AnimationType)-> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
}
