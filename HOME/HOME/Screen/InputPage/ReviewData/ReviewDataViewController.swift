//
//  ReviewDataViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/26/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import SCLAlertView

class ReviewDataViewController: BaseViewController {
    
    @IBOutlet var mReviewData: UITextView!
    
    override func viewDidLoad() {
        self.title = "Review Data"
        super.viewDidLoad()
        
        let exportButton = UIBarButtonItem(title: "Export", style: .plain, target: self, action: #selector(confirmSaveDataAlert))
        exportButton.tintColor = .white
        navigationItem.rightBarButtonItem = exportButton
        
        mReviewData.text = Bussiness.manage.getAllPaper()
    }
    
    @objc func confirmSaveDataAlert() {
        let alert = SCLAlertView()
        _ = alert.addButton("Confirm") {
            let file = Date.getCurrent_MonthYearString() + ".txt"
            let contents = Bussiness.manage.getAllPaper()
            
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                try contents.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                print("Error: \(error)")
            }
        }
        _ = alert.showSuccess("Saved to Files App!", subTitle: "File name's: \(Date.getCurrent_MonthYearString()).txt")
    }
}
