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
    let mCurrentMonth = Date.getCurrentMonth()
    let mPreviousMonth = Date.getLastMonth()
    
    func observeUserDataWithDate(date: String, completion: @escaping (UserData) -> Void) {
        USERDATA_REF.child(date).observe(.childAdded) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let userData = UserData.transfermUser(dictionary: dictionary)
                completion(userData)
            }
        }
    }
    
    func checkDataExisted(date: String, nonExisted: @escaping () -> Void, existed: @escaping () -> Void) {
        USERDATA_REF.child(date).observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
                nonExisted()
            } else {
                existed()
            }
        }
    }
    
    func saveUserData(roomId: String, elecValue: Int, waterValue: Int) {
        USERDATA_REF.child(mCurrentMonth).child(roomId).setValue(["mDateWrote": mCurrentMonth, "mRoomId": roomId, "mElecValue": elecValue, "mWaterValue": waterValue, "mState": false])
    }
    
    func setStateUserWith(id: String) {
        USERDATA_REF.child(mCurrentMonth).child(id).child("mState").setValue(true)
    }
    
    func saveManageData(totalOfMonth: Int, totalFees: Int, recieved: Int) {
        MANAGE_REF.child(mCurrentMonth).setValue(["mTotalBalanceOfMonth": totalOfMonth, "mTotalFees": totalFees, "mRecieved": recieved])
    }
}
