//
//  CellAdd.swift
//  HOME
//
//  Created by Trọng Tín on 07/03/2021.
//  Copyright © 2021 TT Nguyen. All rights reserved.
//

import UIKit

let didAddNewUser = "didAddNewUser"

class CellAdd: UITableViewCell {
    
    var nIsClickedClearButton = Notification.Name(isClickedClearButton)
    var nIsClickedSaveButton = Notification.Name(isClickedSaveButton)
    var nDidAddNewUser = Notification.Name(didAddNewUser)
    
    @IBOutlet var backGround: UILabel!
    
    @IBOutlet var mRoomID: BaseTextInput?
    @IBOutlet var mFirstDeposit: BaseNumberInput?
    @IBOutlet var mRoomFee: BaseNumberInput?
    @IBOutlet var mName: BaseTextInput?
    @IBOutlet var mDateJoined: BaseDateInput?
    @IBOutlet var mPhoneNumber: BaseNumberInput?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(saveData), name: nIsClickedSaveButton, object: nil)
    }

    private func setupView() {
        backGround.layer.cornerRadius = 7.0
        backGround.layer.masksToBounds = true
        
        clearAllDidInput()
        
        let str = "Let input "
        mRoomID!.placeholder = str + "Room ID"
        mFirstDeposit!.placeholder = str + "First Deposit"
        mRoomFee!.placeholder = str + "Room Fee"
        mName!.placeholder = str + "User Name"
        mDateJoined!.placeholder = str + "Date Joined"
        mPhoneNumber!.placeholder = str + "Phone Number"
    }
    
    func clearAllDidInput() {
        mRoomID?.text = ""
        mFirstDeposit?.text = ""
        mRoomFee?.text = ""
        mName?.text = ""
        mDateJoined?.text = ""
        mPhoneNumber?.text = ""
    }
    
    @objc func saveData() {
        
        let newUser = User()
        var newUserData = UserData()
        
        newUser.mRoomId = mRoomID?.text
        newUser.mFirstDeposit = Int((mFirstDeposit?.text)!)
        newUser.mRoomFees = Int((mRoomFee?.text)!)
        newUser.mUsername = mName?.text
        newUser.mDateJoined = mDateJoined?.text
        newUser.mPhoneNumber = mPhoneNumber?.text
        
        newUserData = UserData.init()
        newUserData.mRoomId = mRoomID?.text
        
        Bussiness.manage.mUser.append(newUser)
        Bussiness.manage.mUser.sort(by: { lhs, rhs in
            return lhs.mRoomId! < rhs.mRoomId!
                                    })
        clearAllDidInput()
        
        API.user.saveUserData(roomId: newUserData.mRoomId!, elecValue: newUserData.mElecValue!, waterValue: newUserData.mWaterValue!, isWifi: newUserData.mWifi!)
        API.user.saveUser(username: newUser.mUsername!, roomId: newUser.mRoomId!, phoneNumber: newUser.mPhoneNumber!, firstDeposit: newUser.mFirstDeposit!, dateJoined: newUser.mDateJoined!, roomFees: newUser.mRoomFees!)
        
        if Bussiness.manage.isCurrentMonth {
            Bussiness.manage.mPreviousUserData.append(newUserData)
            Bussiness.manage.mPreviousUserData.sort(by: { lhs, rhs in return lhs.mRoomId! < rhs.mRoomId!})
        } else {
            Bussiness.manage.mUserData.append(newUserData)
            Bussiness.manage.mUserData.sort(by: { lhs, rhs in return lhs.mRoomId! < rhs.mRoomId!})
        }
        
        NotificationCenter.default.post(name: nDidAddNewUser, object: nil)
    }
    
}
