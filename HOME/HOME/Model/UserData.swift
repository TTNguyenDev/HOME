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
    var mDateWrote: String?
    var mRoomId: String?
    var mElecValue: Int?
    var mWaterValue: Int?
    
    init() {
        mDateWrote = ""
        mRoomId = ""
        mElecValue = 0 
        mWaterValue = 0
    }
    
    init(roomId: String, elecValue: Int, waterValue: Int) {
        mDateWrote = Date.getCurrent_MonthYear()
        mRoomId = roomId
        mElecValue = elecValue
        mWaterValue = waterValue
        
        API.user.saveUserData(roomId: mRoomId!, elecValue: mElecValue!, waterValue: mWaterValue!) 
    }
}

extension UserData {
    static func transformUser(dictionary: NSDictionary) -> UserData {
        let userData = UserData()
        userData.mDateWrote = dictionary["mDateWrote"] as? String
        userData.mRoomId = dictionary["mRoomId"] as? String
        userData.mElecValue = dictionary["mElecValue"] as? Int
        userData.mWaterValue = dictionary["mWaterValue"] as? Int
        return userData
    }
}