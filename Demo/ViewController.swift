//
//  ViewController.swift
//  Demo
//
//  Created by Tino Heth on 14.12.16.
//  Copyright © 2016 Tino Heth. All rights reserved.
//

import UIKit

import Hoverboard

class ViewController: UIViewController {

	@IBOutlet weak var textField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}


	override func viewDidAppear(_ animated: Bool) {
		//textField.hoverAboveKeyboard()
	}

	@IBAction func resign(_ sender: Any) {
		textField.resignFirstResponder()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

