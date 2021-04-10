//
//  Path.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

struct Path {
    
    var value: String!
    
    public func build(with strings: String...) -> String {
        var index = 0
        var stringArray: [String] = self.value.split{$0 == "/"}.map { (string) -> String in
            if isValidReplacementFormat(string: String(string)) && strings.count > index {
                index += 1
                return strings[index - 1]
            }
            return String(string)
        }
        if strings.count > index {
            for i in index...strings.count - 1 {
                stringArray.append(strings[i])
            }
        }
        return stringArray.joined(separator: "/")
    }
    
    public func build() -> String {
        var index = 0
        let stringArray: [String?] = self.value.split{$0 == "/"}.map { (string) -> String? in
            if isValidReplacementFormat(string: String(string)) {
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
    
    private func isValidReplacementFormat(string: String) -> Bool {
        let replaceRegex = "[{].+[}]"
        let replaceFormatTest = NSPredicate(format:"SELF MATCHES %@", replaceRegex)
        return replaceFormatTest.evaluate(with: string)
    }
    
}
