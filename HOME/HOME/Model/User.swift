//
//  User.swift
//  HOME
//
//  Created by TT Nguyen on 1/23/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import Foundation

class User {
    var mUsername: String?
    var mRoomId: String?
    var mRoomFees: Int?
    var mPhoneNumber: String?
    var mFirstDeposit: CLongDouble?
    var mDateJoined: String?
    
    init() {
        mUsername = ""
        mRoomId = ""
        mRoomFees = 0
        mPhoneNumber = ""
        mFirstDeposit = 0
        mDateJoined = ""
    }
    
    init(username: String, roomId: String, phoneNumber: String, firstDeposit: CLongDouble, dateJoined: String) {
        mUsername = username
        mRoomId = roomId
        mPhoneNumber = phoneNumber
        mFirstDeposit = firstDeposit
        mDateJoined = dateJoined
    }
    
     func getRoomFeesUsingRoomId(roomId: String) -> Int{
        if roomId == mRoomId {
            return mRoomFees!
        }
        return 0
    }
}
