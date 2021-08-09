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
    let USERDATA_REF = BASE_URL!.child("UserData")
    let MANAGE_REF = BASE_URL!.child("Manage")
    let USER_REF = BASE_URL!.child("User")
    let mCurrentMonth = Date.getCurrentMonth()
    let mPreviousMonth = Date.getLastMonth()
    
//    func observeNumOfRoom ()-> Int {
//        var num: Int?
//        USER_REF.observe(.value, with: { (snapshot: DataSnapshot!) in
//            num = Int(snapshot.childrenCount)
//            print(snapshot.childrenCount)
//        })
//        return 6
//    }
    
    func observeUserDataWithDate(date: String, completion: @escaping (UserData) -> Void) {
        USERDATA_REF.child(date).observe(.childAdded) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let userData = UserData.transfermUser(dictionary: dictionary)
                completion(userData)
            }
        }
    }
    
    func observeUser (completion: @escaping (User) -> Void) {
        USER_REF.observe(.childAdded) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let user = User.transfermUser(dictionary: dictionary)
                completion(user)
            }
        }
    }
    
    func observeSingleUser (_ roomId: String, completion: @escaping (User) -> Void) {
        USER_REF.child(roomId).observe(.childAdded) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let user = User.transfermUser(dictionary: dictionary)
                completion(user)
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
    
    func saveUserData(roomId: String, elecValue: Int, waterValue: Int, isWifi: Bool) {
        USERDATA_REF.child(mCurrentMonth).child(roomId).setValue(["mDateWrote": mCurrentMonth, "mRoomId": roomId, "mElecValue": elecValue, "mWaterValue": waterValue, "isWifi": isWifi, "mState": false])
    }
    
    func saveUser(username: String, roomId: String, phoneNumber: String, firstDeposit: Int, dateJoined: String, roomFees: Int) {
        USER_REF.child(roomId).setValue(["mDateJoined": dateJoined, "mFirstDeposit": firstDeposit, "mPhoneNumber": phoneNumber, "mRoomFees": roomFees, "mRoomId": roomId, "mUsername": username])
    }
    
    func setStateUserWith(id: String) {
        USERDATA_REF.child(mCurrentMonth).child(id).child("mState").setValue(true)
    }
    
    func saveManageData(totalOfMonth: Int, totalFees: Int, recieved: Int) {
        MANAGE_REF.child(mCurrentMonth).setValue(["mTotalBalanceOfMonth": totalOfMonth, "mTotalFees": totalFees, "mRecieved": recieved])
    }

    func getNumberOfRoom(completetion: @escaping (Int) -> Void) {
        USER_REF.observe(.childAdded) { (snapShot) in
            completetion(Int(snapShot.childrenCount))
        }
    }
}
