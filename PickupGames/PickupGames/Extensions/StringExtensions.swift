//
//  StringExtensions.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/27/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

extension String {
    public func pathBuilder(replacementStrings: String...) -> String {
        var index = 0
        var stringArray: [String] = self.split{$0 == "/"}.map { (string) -> String in
            if String(string).isValidReplacementFormat() && replacementStrings.count > index {
                index += 1
                return replacementStrings[index - 1]
            }
            return String(string)
        }
        if replacementStrings.count > index {
            for i in index...replacementStrings.count - 1 {
                stringArray.append(replacementStrings[i])
            }
        }
        return stringArray.joined(separator: "/")
    }
    
    public func pathBuilder() -> String {
        var index = 0
        let stringArray: [String?] = self.split{$0 == "/"}.map { (string) -> String? in
            if String(string).isValidReplacementFormat() {
                index += 1
                return nil
            }
            return String(string)
        }
        var newStringArray = [String]()
        for case let string? in stringArray {
            newStringArray.append(string)
        }
        return newStringArray.joined(separator: "/")
    }
    
    public func isValidReplacementFormat() -> Bool {
        let replaceRegex = "[{].+[}]"
        let replaceFormatTest = NSPredicate(format:"SELF MATCHES %@", replaceRegex)
        return replaceFormatTest.evaluate(with: self)
    }
}
