//
//  Manage.swift
//  HOME
//
//  Created by TT Nguyen on 1/24/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Manage {
    var mUserData = [UserData]()
    var mPreviousUserData = [UserData]()
    var mTotalOfEachRoom = [Int]()          //*
    var mWaterFeesOfEachRoom = [Int]()      //*
    var mElecFeesOfEachRoom = [Int]()       //*
    var mPaperForEachRoom = [String]()
    var mTotalBalance: Int?
    var mTotalBalanceOfMonth: Int?
    var mRecieved: Int  = 0      //*
    var mTotalFees: Int? //*
    
    init() {}
    
    func ditInit(completion: @escaping () -> Void){
        API.user.observeUserDataWithDate(date: "01_2019") { (previousUserData) in
            self.mPreviousUserData.append(previousUserData)
        }
        
        API.user.observeUserDataWithDate(date: "02_2019") { (userData) in
            self.mUserData.append(userData)
            
            if self.mUserData.count == 6 {
                self.calculateWith(previousUserData: self.mPreviousUserData, userData: self.mUserData)
                completion()
            }
        }
    }
    
    func transferRoomID(roomID: String) -> String {
        switch roomID {
        case "p1_1":
            return "pòng 1 tầng 1"
        case "p3_1":
            return " hòng 3 tầng 1"
        case "p1_2":
            return "phòng 1 tầng 2"
        case "p2_2":
            return "phòng 2 tầng 2"
        case "p3_2":
            return "phòng 3 tầng 2"
        case "p4_2":
            return "phòng 4 tầng 2"
        default:
            return "error"
        }
    }
    
    func regconizeUserById(id: String) -> Int {
        switch id {
        case "p1_1":
            return 0
        case "p3_1":
            return 1
        case "p1_2":
            return 2
        case "p2_2":
            return 3
        case "p3_2":
            return 4
        case "p4_2":
            return 5
        default:
            return -1
        }
        
    }
    
    func calculateWith(previousUserData: [UserData], userData: [UserData])  {
        for i in 0..<userData.count {
            let elecUsed = (userData[i].mElecValue! - previousUserData[i].mElecValue!) * mElecFees
            let waterUsed = (userData[i].mElecValue! - previousUserData[i].mElecValue!) * mWaterFees
            let sum = elecUsed + waterUsed + mRoomFees[i] + mOtherFees
            
            mElecFeesOfEachRoom.append(elecUsed)
            mWaterFeesOfEachRoom.append(waterUsed)
            mTotalOfEachRoom.append(sum)
        }
        mTotalBalanceOfMonth = mTotalOfEachRoom.reduce(0, +)
        mTotalFees = mElecFeesOfEachRoom.reduce(0, +) + mWaterFeesOfEachRoom.reduce(0, +)
        
        API.user.saveManageData(totalOfMonth: mTotalBalanceOfMonth!, totalFees: mTotalFees!)
    }
    
    //Cal calculate func before doing anything
    func getTotalOfRoomWithID(id: String) -> Int {
        return mTotalOfEachRoom[regconizeUserById(id: id)]
    }
    
    func getPaperOfRoomWithID(id: String) -> String {
        return mPaperForEachRoom[regconizeUserById(id: id)]
    }
    
    func getAllPaper() -> String {
        var paper = ""
        for i in 0..<6 {
            
            let paperForEachRoom = """
            
                            Phiếu thu tiền \(transferRoomID(roomID: mUserData[i].mRoomId!))
                              ---------- @@ ----------
            
                - Tiền phòng: \(mRoomFees[i])
                - Điện:
                    + Tháng này: \(mUserData[i].mElecValue!)
                    + Tháng trước: \(mPreviousUserData[i].mElecValue!)
                    + Tiêu thụ: (\(mUserData[i].mElecValue!) - \(mPreviousUserData[i].mElecValue!)) x \(mElecFees) = \(mElecFeesOfEachRoom[i])
            
                - Nước:
                    + Tháng này: \(mUserData[i].mWaterValue!)
                    + Tháng trước: \(mPreviousUserData[i].mWaterValue!)
                    + Tiêu thụ: (\(mUserData[i].mWaterValue!) - \(mPreviousUserData[i].mWaterValue!)) x \(mWaterFees) = \(mWaterFeesOfEachRoom[i])
            
                - Tiền rác: \(mOtherFees)
                - TỔNG CỘNG: \(mTotalOfEachRoom[i])
                            (Ghi chú: điện: 3300/kW, nước: 5000/khối)
            
            """
            
            mPaperForEachRoom.append(paperForEachRoom)
            paper += paperForEachRoom
        }
        return paper
    }
}


extension Manage {
    static func transformManage(dictionary: NSDictionary) -> Manage {
        let manage = Manage()
        manage.mTotalBalanceOfMonth = dictionary["mTotalBalanceOfMonth"] as? Int
        manage.mTotalFees = dictionary["mTotalFees"] as? Int
        return manage
    }
}
