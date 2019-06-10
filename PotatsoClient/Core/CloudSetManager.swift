//
//  CloudSetManager.swift
//  Potatso
//
//  Created by LEI on 8/13/16.
//  Copyright © 2016 TouchingApp. All rights reserved.
//

import Foundation
import Async
import RealmSwift
import PotatsoModel

public class CloudSetManager {

    public static let shared = CloudSetManager()

    fileprivate init() {

    }

    public func update(completion: (([String]?) -> Void)?) {
        Async.background(after: 1.5) {
            let realm = try! Realm()
            let uuids = realm.objects(RuleSet.self).filter("isSubscribe = true").map({$0.uuid})
            
            var uuidsArray: [String] = []
            uuids.forEach({ (tObj) in
                uuidsArray.append(tObj as String)
            })
            
            completion?(uuidsArray);
            
//            移除到外部
//            API.updateRuleSetListDetail(uuidsArray) { (response) in
//                if let sets = response.result.value {
//                    do {
//                        try RuleSet.addRemoteArray(sets)
//                    }catch {
//                        error.log("Unable to save updated rulesets")
//                        return
//                    }
//                }else {
//                    response.result.error?.log("Fail to update ruleset details")
//                }
//            }
        }
    }
}
