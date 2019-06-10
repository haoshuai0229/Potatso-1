//
//  UIManager.swift
//  idongtuvpn
//
//  Created by yjh易佳豪 on 2019/5/15.
//  Copyright © 2019 jhyi. All rights reserved.
//

import Foundation
import ICSMainFramework

class UIManager: NSObject, AppLifeCycleProtocol {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
  
        UIView.appearance().tintColor =  Color.Brand

        UITableView.appearance().backgroundColor = Color.Background
        UITableView.appearance().separatorColor = Color.Separator

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = Color.NavigationBackground

        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = Color.TabBackground
        UITabBar.appearance().tintColor = Color.TabItemSelected

        keyWindow?.rootViewController = makeRootViewController()
        return true
    }
    
    func makeRootViewController() -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = makeChildViewControllers()
        tabBarVC.selectedIndex = 0
        return tabBarVC
    }
    
    func makeChildViewControllers() -> [UIViewController] {
        let cons: [(UIViewController.Type, String, String)] = [(HomeVC.self, "Home".localized(), "Home"),(CollectionViewController.self, "Manage".localized(), "Config"),(DashboardVC.self, "Statistics".localized(), "Dashboard"),(SettingsViewController.self, "More".localized(), "More")]
        return cons.map {
            let vc = UINavigationController(rootViewController: $0.init())
            vc.tabBarItem = UITabBarItem(title: $1, image: $2.originalImage, selectedImage: $2.templateImage)
            return vc
        }
    }
    
}
