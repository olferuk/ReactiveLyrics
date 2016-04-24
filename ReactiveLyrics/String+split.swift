//
//  String+split.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 23/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

import UIKit

extension String {
    // java, javascript, PHP use 'split' name, why not in Swift? :)
    func split(regex: String) -> Array<String> {
        do {
            let regEx = try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions())
            let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
            let modifiedString = regEx.stringByReplacingMatchesInString (self, options: NSMatchingOptions(), range: NSMakeRange(0, characters.count), withTemplate: stop)
            return modifiedString.componentsSeparatedByString(stop)
        } catch {
            return []
        }
    }
}