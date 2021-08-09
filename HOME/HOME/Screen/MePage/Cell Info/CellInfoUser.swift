//
//  CellInfoUser.swift
//  HOME
//
//  Created by Trọng Tín on 16/02/2021.
//  Copyright © 2021 TT Nguyen. All rights reserved.
//

import UIKit

protocol InfoUserDelegate: NSObject {
    func isClickDoneButton(_ indexRow: IndexPath, _ mRoomId: UILabel, _ mUsername: UITextField, _ mDateJoined: UITextField, _ FirstDeposit: UITextField, _ mPhoneNumber: UITextField, _ mRoomFees: UITextField)
}

class CellInfoUser: UITableViewCell {

    @IBOutlet var room: UILabel!
    @IBOutlet var roomID: UILabel!
    @IBOutlet var backGround: UILabel!
    @IBOutlet var mUserName: BaseTextInput!
    @IBOutlet var mDateJoined: BaseDateInput!
    @IBOutlet var FirstDeposit: BaseTextInput!
    @IBOutlet var mPhoneNumber: BaseTextInput!
    @IBOutlet var mRoomFees: BaseTextInput!
    
    var isClickEdit = true
    var index: IndexPath?
    weak var delegate: InfoUserDelegate?
    
    var doneButton: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        doneButton = UIButton(type: .custom)
        doneButton.frame = CGRect(x: self.frame.width - 50, y: 20, width: 45, height: 15)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        doneButton.isHidden = true
        self.addSubview(doneButton)
        room.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        room.font = UIFont.boldSystemFont(ofSize: 20)
        roomID.font = UIFont.boldSystemFont(ofSize: 20)
        roomID.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        backGround.layer.cornerRadius = 10
        backGround.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        mUserName.text = ""
        mUserName.placeholder = ""
        mDateJoined.text = ""
        mDateJoined.placeholder = ""
        FirstDeposit.text = ""
        FirstDeposit.placeholder = ""
        mPhoneNumber.text = ""
        mPhoneNumber.placeholder = ""
        mRoomFees.text = ""
        mRoomFees.placeholder = ""
        roomID.text = ""
        doneButton.isHidden = true
    }

    @IBAction func done(_ sender: Any) {
        delegate?.isClickDoneButton(index!, roomID, mUserName, mDateJoined, FirstDeposit, mPhoneNumber, mRoomFees)
        doneButton.isHidden = true
        mUserName.placeholder = mUserName.text
        mDateJoined.placeholder = mDateJoined.text
        FirstDeposit.placeholder = FirstDeposit.text
        mPhoneNumber.placeholder = mPhoneNumber.text
        mRoomFees.placeholder = mRoomFees.text
        mUserName.text = ""
        mDateJoined.text = ""
        FirstDeposit.text = ""
        mPhoneNumber.text = ""
        mRoomFees.text = ""
        mUserName.isUserInteractionEnabled = false
        mDateJoined.isUserInteractionEnabled = false
        FirstDeposit.isUserInteractionEnabled = false
        mPhoneNumber.isUserInteractionEnabled = false
        mRoomFees.isUserInteractionEnabled = false
    }
}
