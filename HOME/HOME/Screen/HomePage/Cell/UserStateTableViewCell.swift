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
    
    
    var buttonAction: ((Any) -> Void)?
    @IBOutlet var mCheckBox: UIView!
    @IBOutlet var mRoomId: UILabel!
    @IBOutlet var mRoomTotalValue: UILabel!
    
    var checkBox:M13Checkbox = {
        let CheckBox = M13Checkbox(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        CheckBox.stateChangeAnimation = .fill
        CheckBox.tintColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        CheckBox.secondaryTintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        return CheckBox
    }()
    
    
    fileprivate func setupCheckBox() {
        mCheckBox.addSubview(checkBox)
        checkBox.addTarget(self, action: #selector(checkBoxValueDidChanged(sender:)), for: .valueChanged)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCheckBox()
    }
    
    @objc func checkBoxValueDidChanged(sender: Any) {
        if checkBox.checkState == .checked {
            checkBox.isEnabled = false
        }
        self.buttonAction?(sender)
    }
}
