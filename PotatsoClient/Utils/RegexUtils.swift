//
//  RegexUtils.swift
//  Potatso
//
//  Created by LEI on 6/23/16.
//  Copyright © 2016 TouchingApp. All rights reserved.
//

import Foundation

public class Regex {

    let internalExpression: NSRegularExpression
    let pattern: String

    public init(_ pattern: String) throws {
        self.pattern = pattern
        self.internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }

    public func test(_ input: String) -> Bool {
        let matches = self.internalExpression.matches(in: input, options: NSRegularExpression.MatchingOptions.reportCompletion, range:NSMakeRange(0, input.count))
        return matches.count > 0
    }

}
