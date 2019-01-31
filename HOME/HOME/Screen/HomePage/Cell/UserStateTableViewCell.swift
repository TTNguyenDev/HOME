//
//  UserStateTableViewCell.swift
//  HOME
//
//  Created by TT Nguyen on 1/28/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import M13Checkbox

let isTouchChecbox = "co.listener.isTouchChexbox"

class UserStateTableViewCell: UITableViewCell {
    
    
    @IBOutlet var mCheckBox: UIView!
    let mIsTouchCheckbox = Notification.Name(isTouchChecbox)
    var buttonAction: ((Any) -> Void)?
    
    var checkBox:M13Checkbox = {
        let CheckBox = M13Checkbox(frame: CGRect(x: 14, y: 5, width: 40, height: 40))
        CheckBox.stateChangeAnimation = .fill
        CheckBox.tintColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        CheckBox.secondaryTintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
       
        return CheckBox
    }()
    
    
    fileprivate func setupCheckBox() {
        mCheckBox.addSubview(checkBox)
        checkBox.addTarget(self, action: #selector(checkBoxValueDidChanged), for: .valueChanged)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCheckBox()
    }
    
    @objc func checkBoxValueDidChanged(sender: Any) {
        if checkBox.checkState == .checked {
            checkBox.isEnabled = false
        }
        NotificationCenter.default.post(name: mIsTouchCheckbox, object: nil)
        self.buttonAction?(sender)
    }
}
