//
//  ElementViewController.swift
//  Ios Assessment 2
//
//  Created by Macy on 6/5/18.
//  Copyright © 2018 James Owen. All rights reserved.
//

import UIKit
import os.log

class ElementViewController: UIViewController {

	@IBOutlet weak var saveButton: UIButton!
	var bird : BirdData?
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender);
		
		// Configure the destination view controller only when the save button is pressed.
		guard let button = sender as? UIBarButtonItem, button === saveButton else {
			os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
			return
		}
		
		//SAVE GOES HERE
		
		let name = "";
		// Set the meal to be passed to MealTableViewController after the unwind segue.
		bird = BirdData(name: name);
		
	}


}
