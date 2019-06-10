//
//  FeedbackManager.swift
//  Potatso
//
//  Created by LEI on 8/4/16.
//  Copyright © 2016 TouchingApp. All rights reserved.
//

import Foundation
import ICSMainFramework
import LogglyLogger_CocoaLumberjack
import PotatsoLibrary

public class FeedbackManager {
    public static let shared = FeedbackManager()

    public func showFeedback(inVC vc: UIViewController? = nil) {
        guard (vc ?? UIApplication.shared.keyWindow?.rootViewController) != nil else {
            return
        }
        _ = [
            "gotoConversationAfterContactUs": "YES"
        ]
        _ = Manager.sharedManager.defaultConfigGroup.ruleSets.map({ $0.name }).joined(separator: ", ")
        _ = Manager.sharedManager.defaultConfigGroup.defaultToProxy
        var tags: [String] = []
        if AppEnv.isTestFlight {
            tags.append("testflight")
        } else if AppEnv.isAppStore {
            tags.append("store")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LogglyLoggerForceUploadNotification"), object: nil)
    }
}
