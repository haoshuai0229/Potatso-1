//
//  DBInitializer.swift
//  Potatso
//
//  Created by LEI on 3/8/16.
//  Copyright © 2016 TouchingApp. All rights reserved.
//

import UIKit
import ICSMainFramework
import CloudKit
import Async
import RealmSwift
import Realm
import PotatsoLibrary
import PotatsoClient

class DataInitializer: NSObject, AppLifeCycleProtocol {

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Manager.sharedManager.setup()
        CloudSetManager.shared.update { (uuidsArray) in
            
        }
        SyncManager.shared.sync()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        _ = try? Manager.sharedManager.regenerateConfigFiles()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        _ = try? Manager.sharedManager.regenerateConfigFiles()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
//        Receipt.shared.validate()
        SyncManager.shared.sync()
    }

}
