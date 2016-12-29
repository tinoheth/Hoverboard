//
//  HoveringScrollView.swift
//  Hoverboard
//
//  Created by Tino Heth on 27.12.16.
//  Copyright © 2016 Tino Heth. All rights reserved.
//

import UIKit

class HoveringScrollView: UIScrollView {
	override func didMoveToWindow() {
		self.hoverAboveKeyboard(keepOffset: true)
	}
}
