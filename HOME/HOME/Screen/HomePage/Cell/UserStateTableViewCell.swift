//
//  UserStateTableViewCell.swift
//  HOME
//
//  Created by TT Nguyen on 1/28/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import M13Checkbox

class UserStateTableViewCell: UITableViewCell {
    
    
    @IBOutlet var mCheckBox: UIView!
    var checkBox:M13Checkbox?
    
    
    fileprivate func setupCheckBox() {
        checkBox = M13Checkbox(frame: CGRect(x: 14, y: 5, width: 40, height: 40))
        checkBox!.stateChangeAnimation = .fill
        checkBox!.tintColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        checkBox!.secondaryTintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        checkBox!.addTarget(self, action: #selector(checkBoxValueDidChanged), for: .valueChanged)
        mCheckBox.addSubview(checkBox!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCheckBox()
    }
    
    @objc func checkBoxValueDidChanged() {
        if checkBox!.checkState == .checked {
            checkBox!.isEnabled = false
        }
    }
    
    
    
    
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
