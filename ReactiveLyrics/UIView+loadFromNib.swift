//
//  UIView.swift
//  yandex_trains_ios
//
//  Created by Ольферук Александр on 03/03/16.
//  Copyright © 2016 Valery Sukovykh. All rights reserved.
//

import UIKit

extension UIView {
	/**
	 Loads view from the nib safely

	 - returns: UIView
	 */
	static func loadFromNib() -> UIView {
		return NSBundle.mainBundle().loadNibNamed(self.nameOfClass, owner: self, options: nil).first as! UIView
	}
}