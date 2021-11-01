//
//  AppDelegate.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UserListViewControllerDefault.initFromStoryboard()
        window?.makeKeyAndVisible()
        
        return true
    }
}
