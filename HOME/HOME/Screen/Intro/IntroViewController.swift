//
//  IntroViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/20/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import LocalAuthentication

public class IntroViewController: UIViewController, UITabBarControllerDelegate {
    

    @IBAction func mFaceIdLogin(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
    
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return print(error)
        }
        
        let reason = "Face ID authentication"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isAuthorized, error in
            guard isAuthorized == true else {
                return print(error)
            }
            
            let tabBarController = ESTabBarController()
            tabBarController.delegate = self
            tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
            tabBarController.tabBar.backgroundColor = UIColor.white
            
            let mHomePage = UINavigationController(rootViewController: HomeViewController())
            let mInputPage = UINavigationController(rootViewController: InputPageViewController())
            let mMePage = UINavigationController(rootViewController: MePageViewController())
            
            mHomePage.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
            mInputPage.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Input", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
            
            mMePage.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "My Account", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
            
            mHomePage.navigationBar.topItem?.title = "Home"
            mInputPage.navigationBar.topItem?.title = "Input"
            mMePage.navigationBar.topItem?.title = "My Account"
            
            tabBarController.viewControllers = [mHomePage, mInputPage, mMePage]
            self.present(tabBarController, animated: true, completion: nil)
        }
       
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
