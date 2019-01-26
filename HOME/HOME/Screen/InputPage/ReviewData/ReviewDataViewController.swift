//
//  ReviewDataViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/26/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

class ReviewDataViewController: BaseViewController {

    @IBOutlet var mReviewData: UITextView!
    override func viewDidLoad() {
        self.title = "Review Data"
        super.viewDidLoad()
        
        mReviewData.text = Bussiness.manage.getAllPaper()
    }


   

}
