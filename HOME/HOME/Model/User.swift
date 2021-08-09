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
    var mFirstDeposit: Int?
    var mDateJoined: String?
    
    init() {
        mUsername = ""
        mRoomId = ""
        mRoomFees = 0
        mPhoneNumber = ""
        mFirstDeposit = 0
        mDateJoined = ""
    }
    
    init(username: String, roomId: String, phoneNumber: String, firstDeposit: Int, dateJoined: String, roomFees: Int) {
        mUsername = username
        mRoomId = roomId
        mPhoneNumber = phoneNumber
        mFirstDeposit = firstDeposit
        mDateJoined = dateJoined
        mRoomFees = roomFees
        
        API.user.saveUser(username: mUsername!, roomId: mRoomId!, phoneNumber: mPhoneNumber!, firstDeposit: mFirstDeposit!, dateJoined: mDateJoined!, roomFees: mRoomFees!)
    }
    
     func getRoomFeesUsingRoomId(roomId: String) -> Int{
        if roomId == mRoomId {
            return mRoomFees!
        }
        return 0
    }
    
    static func transfermUser(dictionary: NSDictionary) -> User {
        let user = User()
        user.mUsername = dictionary["mUsername"] as? String
        user.mRoomId = dictionary["mRoomId"] as? String
        user.mRoomFees = dictionary["mRoomFees"] as? Int
        user.mPhoneNumber = dictionary["mPhoneNumber"] as? String
        user.mFirstDeposit = dictionary["mFirstDeposit"] as? Int
        user.mDateJoined = dictionary["mDateJoined"] as? String
        return user
    }
}
