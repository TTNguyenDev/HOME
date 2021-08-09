//
//  CellPageOfEachRoom.swift
//  HOME
//
//  Created by Trọng Tín on 19/03/2021.
//  Copyright © 2021 TT Nguyen. All rights reserved.
//

import UIKit

class CellPageOfEachRoom: UITableViewCell {

    @IBOutlet var UIText: UITextView!
    @IBOutlet var backGround: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        backGround.layer.cornerRadius = 10
        backGround.layer.masksToBounds = true
        UIText.isEditable = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
