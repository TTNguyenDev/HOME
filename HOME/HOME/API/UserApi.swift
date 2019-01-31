//
//  UserApo.swift
//  HOME
//
//  Created by TT Nguyen on 1/24/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserApi {
    let USERDATA_REF = Database.database().reference().child("UserData")
    let MANAGE_REF = Database.database().reference().child("Manage")
    let mDateWrote = Date.getCurrent_MonthYear()
    
    func observeUserDataWithDate(date: String, completion: @escaping (UserData) -> Void) {
        USERDATA_REF.child(date).observe(.childAdded) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let userData = UserData.transfermUser(dictionary: dictionary)
                completion(userData)
            }
        }
    }
    
    func saveUserData(roomId: String, elecValue: Int, waterValue: Int) {
        USERDATA_REF.child("02_2019").child(roomId).setValue(["mDateWrote": mDateWrote, "mRoomId": roomId, "mElecValue": elecValue, "mWaterValue": waterValue, "mState": false])
    }
    
    func setStateUserWith(id: String) {
        USERDATA_REF.child("02_2019").child(id).child("mState").setValue(true)
    }
    
    func saveManageData(totalOfMonth: Int, totalFees: Int) {
        MANAGE_REF.child("02_2019").setValue(["mTotalBalanceOfMonth": totalOfMonth, "mTotalFees": totalFees])
    }
    
    func observeManageData(completion: @escaping (Manage) -> Void) {
        MANAGE_REF.child("01_2019").observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let manageData = Manage.transformManage(dictionary: dictionary)
                completion(manageData)
            }
        }
    }
}
