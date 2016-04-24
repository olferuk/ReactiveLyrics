//
//  UIViewController.swift
//  yandex_trains_ios
//
//  Created by Ольферук Александр on 03/03/16.
//  Copyright © 2016 Valery Sukovykh. All rights reserved.
//

import Foundation
import UIKit

// MARK: Returns view controller that is displayed on the screen
extension UIViewController {
	static func currentVc() -> UIViewController {
		var rootVC = UIApplication.sharedApplication().keyWindow!.rootViewController
		while (true) {
			if let vc = rootVC {
				var next: UIViewController? = nil
				if let presentedVC = vc.presentedViewController {
					next = presentedVC
				}
				else if vc.isKindOfClass(UITabBarController) {
					let tabVC = vc as! UITabBarController
					next = tabVC.selectedViewController
				}
				else if vc.isKindOfClass(UINavigationController) {
					let navVC = vc as! UINavigationController
					next = navVC.topViewController;
				}
				if let next = next {
					rootVC = next
				}
				else {
					break
				}
			}
		}
		return rootVC!
	}
}