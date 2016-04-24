//
//  UIResponder.swift
//  yandex_trains_ios
//
//  Created by Ольферук Александр on 05/03/16.
//  Copyright © 2016 Valery Sukovykh. All rights reserved.
//

import UIKit

// UIResponder is a parent for both UIView and UIViewController (and their descendants)
extension UIResponder {
    class var nameOfClass: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }

    var nameOfClass: String {
        return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
    }
}