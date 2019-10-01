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
import UserNotifications

public class IntroViewController: UIViewController, UITabBarControllerDelegate,  UNUserNotificationCenterDelegate {
    
    
    @IBAction func mFaceIdLogin(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return print(error!)
        }
        
        let reason = "Face ID authentication"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isAuthorized, error in
            guard isAuthorized == true else {
                return print(error!)
            }
            
            DispatchQueue.main.async {
                let mHomePage = UINavigationController(rootViewController: HomeViewController())
                let mInputPage = UINavigationController(rootViewController: InputPageViewController())
                let mMePage = UINavigationController(rootViewController: MePageViewController())
                mHomePage.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
                
                mInputPage.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Input", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
                
                mMePage.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "My Account", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
                
                let tabBarController = ESTabBarController()
                tabBarController.delegate = self
                tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
                tabBarController.tabBar.backgroundColor = UIColor.white
                
                mHomePage.navigationBar.topItem?.title = "Home"
                mInputPage.navigationBar.topItem?.title = "Input"
                mMePage.navigationBar.topItem?.title = "My Account"
                
                tabBarController.addChild(mHomePage)
                tabBarController.addChild(mInputPage)
                tabBarController.addChild(mMePage)
                
                if #available(iOS 13.0, *) {
                    let navBarAppearance = UINavigationBarAppearance()
                    navBarAppearance.titleTextAttributes = [.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
                    navBarAppearance.largeTitleTextAttributes = [.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
                    navBarAppearance.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
//                    navBarAppearance.configureWithOpaqueBackground()
                    
                    mHomePage.navigationBar.standardAppearance = navBarAppearance
                    mHomePage.navigationBar.scrollEdgeAppearance = navBarAppearance
                    
                    mInputPage.navigationBar.standardAppearance = navBarAppearance
                    mInputPage.navigationBar.scrollEdgeAppearance = navBarAppearance
                    
                    mMePage.navigationBar.standardAppearance = navBarAppearance
                    mMePage.navigationBar.scrollEdgeAppearance = navBarAppearance
                } else {
                    // Fallback on earlier versions
                }
                
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = UNMutableNotificationContent()
        content.title = "Alert"
        content.body = "Today is 5th, let's get room fees"
        content.badge = 1
        
        UNUserNotificationCenter.current().delegate = self
        
        var morningAlert = DateComponents()
        morningAlert.hour = 8
        morningAlert.minute = 00
        morningAlert.day = 05
        
        var eveningAlert = DateComponents()
        eveningAlert.hour = 19
        eveningAlert.minute = 00
        eveningAlert.day = 05
        
        let morningTrigger = UNCalendarNotificationTrigger(dateMatching: morningAlert, repeats: true)
        let eveningTrigger = UNCalendarNotificationTrigger(dateMatching: eveningAlert, repeats: true)
        
        let morningRequest = UNNotificationRequest(identifier: "Request with DateComponents", content: content, trigger: morningTrigger)
        
        let eveningRequest = UNNotificationRequest(identifier: "Request with DateComponents", content: content, trigger: eveningTrigger)
        
        UNUserNotificationCenter.current().add(morningRequest, withCompletionHandler: nil)
        UNUserNotificationCenter.current().add(eveningRequest, withCompletionHandler: nil)
        UNUserNotificationCenter.current().delegate = self
    }
}
