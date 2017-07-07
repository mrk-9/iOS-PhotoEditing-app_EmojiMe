//
//  AppDelegate.swift
//  emojime
//
//  Created by Billy on 04/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //let tabBar = ( window?.rootViewController as! UITabBarController ).tabBar
        // Change color of text of tab bar
        //tabBar.tintColor = UIColor.white
        // Change background color of selected tab item
        //let numberOfItems = CGFloat((tabBar.items?.count)!)
        //let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        //tabBar.selectionIndicatorImage = UIImage.imageWithColor(UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0), size: tabBarItemSize).resizableImage(withCapInsets: UIEdgeInsets.zero)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func changeRootController(_ imageToCrop: UIImage) {
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        let navigationController = storyBoard.instantiateViewController(withIdentifier: "NavEditPhotoView") as! UINavigationController
        let editPhotoVC = (navigationController.viewControllers.first) as! EditPhotoViewController
        editPhotoVC.imageArg = imageToCrop
        self.window?.rootViewController = navigationController
    }
    
    func changeRootTabController(tabIndex: Int) {
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        let tabBarController = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        tabBarController.selectedIndex = tabIndex
        let tabBar = tabBarController.tabBar
        // Change color of text of tab bar
        tabBar.tintColor = UIColor.white
        // Change background color of selected tab item
        let numberOfItems = CGFloat((tabBar.items?.count)!)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0), size: tabBarItemSize).resizableImage(withCapInsets: UIEdgeInsets.zero)
        self.window?.rootViewController = tabBarController
        
    }
}
