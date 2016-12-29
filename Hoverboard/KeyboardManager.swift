//
//  Hoverboard.swift
//  Hoverboard
//
//  Created by Tino Heth on 14.12.16.
//  Copyright © 2016 Tino Heth. All rights reserved.
//

import UIKit

@objc class KeyboardManager: NSObject {

	private(set) public static var sharedInstance = KeyboardManager()

	var guide = UILayoutGuide()
	var keyboardTop: NSLayoutConstraint?
	var window: UIWindow?

	@IBOutlet var children = [UIView]()

	override init() {
		super.init()
		NotificationCenter.default.addObserver(self, selector: #selector(update), name: .UIKeyboardWillChangeFrame, object: nil)
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	@discardableResult
	func constraintInWindow(window: UIWindow) -> NSLayoutConstraint {
		if let value = self.keyboardTop {
			return value
		}
		else {
			let constraint = window.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
			window.addLayoutGuide(guide)
			constraint.isActive = true
			self.keyboardTop = constraint
			return constraint
		}
	}

	@objc func update(notification: Notification) {
		guard let dict = notification.userInfo,
			let frame = dict[UIKeyboardFrameEndUserInfoKey] as? CGRect,
			let duration = dict[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
			let window = window ?? UIApplication.shared.keyWindow else {
			return
		}
		self.window = window

		let converted = window.convert(frame, from: nil)
		let constraint = constraintInWindow(window: window)
		window.layoutIfNeeded()
		UIView.animate(withDuration: duration) {
			if converted.origin.y >= window.bounds.height {
				constraint.constant = 0
			} else {
				constraint.constant = converted.height
			}
			window.layoutIfNeeded()
		}
	}
}

extension UIWindow {
	public var keyboard: NSLayoutYAxisAnchor {
		KeyboardManager.sharedInstance.constraintInWindow(window: self)
		return KeyboardManager.sharedInstance.guide.topAnchor
	}

	public func keepViewAboveKeyboard(view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
		let constraint = keyboard.constraint(greaterThanOrEqualTo: view.bottomAnchor)
		constraint.constant = offset
		constraint.isActive = true
		return constraint
	}
}

extension UIView {
	public func hoverAboveKeyboard(keepOffset: Bool = true) {
		var offset = CGFloat(0)
		if keepOffset {
			if let window = self.window {
				window.layoutIfNeeded()
				let max = window.convert(bounds, from: self).maxY
				offset = window.frame.height - max
			}
		}
		self.window?.keepViewAboveKeyboard(view: self, offset: offset)
	}

	public func hoverAboveKeyboard(offset: CGFloat) {
		self.window?.keepViewAboveKeyboard(view: self, offset: offset)
	}
}
