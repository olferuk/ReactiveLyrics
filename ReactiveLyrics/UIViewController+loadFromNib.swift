//
//  UIViewController+loadFromNib.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 21/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

import UIKit

// MARK: Loading from nib named exactly the same as UIViewController's class itself
extension UIViewController {
	class func loadFromNib() -> UIViewController {
		let classReference = self.self
		return classReference.init(nibName: self.nameOfClass, bundle: nil)
	}
}
