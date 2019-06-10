//
//  SyncManager.swift
//  Potatso
//
//  Created by LEI on 8/2/16.
//  Copyright © 2016 TouchingApp. All rights reserved.
//

import UIKit
import CloudKit

public enum SyncServiceType: String {
    case None
    case iCloud
}

public protocol SyncServiceProtocol {
    func setup(_ completion: ((Error?) -> Void)?)
    func sync(_ manually: Bool, completion: ((Error?) -> Void)?)
    func stop()
}

public class SyncManager {

    public static let shared = SyncManager()

    public static let syncServiceChangedNotification = "syncServiceChangedNotification"
    fileprivate var services: [SyncServiceType: SyncServiceProtocol] = [:]
    fileprivate static let serviceTypeKey = "serviceTypeKey"

    public var syncing = false

    public var currentSyncServiceType: SyncServiceType {
        get {
            if let raw = UserDefaults.standard.object(forKey: SyncManager.serviceTypeKey) as? String, let type = SyncServiceType(rawValue: raw) {
                return type
            }
            return .None
        }
        set(new) {
            guard currentSyncServiceType != new else {
                return
            }
            getCurrentSyncService()?.stop()
            UserDefaults.standard.set(new.rawValue, forKey: SyncManager.serviceTypeKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: SyncManager.syncServiceChangedNotification), object: nil)
        }
    }

    init() {
    }

    public func getCurrentSyncService() -> SyncServiceProtocol? {
        return getSyncService(forType: currentSyncServiceType)
    }

    public func getSyncService(forType type: SyncServiceType) -> SyncServiceProtocol? {
        if let service = services[type] {
            return service
        }
        let s: SyncServiceProtocol
        switch type {
        case .iCloud:
            s = ICloudSyncService()
        default:
            return nil
        }
        services[type] = s
        return s
    }

    public func showSyncVC(syncVC: UIViewController, inVc:UIViewController? = nil) {
        guard let currentVC = inVc ?? UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        currentVC.show(syncVC, sender: self)
    }

}

extension SyncManager {

    public func setupNewService(_ type: SyncServiceType, completion: ((Error?) -> Void)?) {
        if let service = getSyncService(forType: type) {
            service.setup(completion)
        } else {
            completion?(nil)
        }
    }

    public func setup(_ completion: ((Error?) -> Void)?) {
        getCurrentSyncService()?.setup(completion)
    }

    public func sync(_ manually: Bool = false, completion: ((Error?) -> Void)? = nil) {
        if let service = getCurrentSyncService() {
            syncing = true
            NotificationCenter.default.post(name: Notification.Name(rawValue: SyncManager.syncServiceChangedNotification), object: nil)
            service.sync(manually) { [weak self] error in
                self?.syncing = false
                NotificationCenter.default.post(name: Notification.Name(rawValue: SyncManager.syncServiceChangedNotification), object: nil)
                completion?(error)
            }
        }
    }
    
}
