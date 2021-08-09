//
//  UserData.swift
//  HOME
//
//  Created by TT Nguyen on 1/23/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserData {
    var mState: Bool?
    var mDateWrote: String?
    var mRoomId: String?
    var mElecValue: Int?
    var mWaterValue: Int?
    var mWifi: Bool?
    
    init() {
        mDateWrote = ""
        mRoomId = ""
        mElecValue = 0 
        mWaterValue = 0
        mState = false
        mWifi = false
    }
    
    init(roomId: String, elecValue: Int, waterValue: Int , isWifi: Bool) {
        mDateWrote = Date.getCurrentMonth()
        mRoomId = roomId
        mElecValue = elecValue
        mWaterValue = waterValue
        mWifi = isWifi
        mState = false
        
        API.user.saveUserData(roomId: mRoomId!, elecValue: mElecValue!, waterValue: mWaterValue!, isWifi: mWifi!)
    }
}

extension UserData {
    static func transfermUser(dictionary: NSDictionary) -> UserData {
        let userData = UserData()
        userData.mDateWrote = dictionary["mDateWrote"] as? String
        userData.mRoomId = dictionary["mRoomId"] as? String
        userData.mElecValue = dictionary["mElecValue"] as? Int
        userData.mWaterValue = dictionary["mWaterValue"] as? Int
        userData.mState = dictionary["mState"] as? Bool
        userData.mWifi = dictionary["isWifi"] as? Bool ?? false
        return userData
    }
}
 
