//
//  ElementViewController.swift
//  Ios Assessment 2
//
//  Created by Macy on 6/5/18.
//  Copyright © 2018 James Owen. All rights reserved.
//

import UIKit
import os.log
import MapKit

//handles the editing of the bird data
class ElementViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

	// MARK: - Elements

	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var BirdName: UITextField!
	@IBOutlet weak var SetImageButton: UIButton!
	@IBOutlet weak var Description: UITextView!
	@IBOutlet weak var BirdDetails: UITextView!
	@IBOutlet weak var OtherInfo: UITextView!
	
	@IBOutlet weak var MapView: MKMapView!	
	
	@IBOutlet weak var ScrollView: UIScrollView!
	
	//reference to the bird data
	//could be null (if we are making a new bird)
	var bird : BirdData?

	// MARK: - Functions
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		//set up delegates and view info
		BirdName.delegate = self;
		Description.delegate = self;
		BirdDetails.delegate = self;
		ScrollView.keyboardDismissMode = .onDrag;
		
		//load bird data

		//were we supplied a bird to edit or are we making a new one?
		if( bird != nil){
			//since we are editing the bird, update the title text
			navigationItem.title = "Edit Bird";

			BirdName.text = bird?.name;
			Description.text = bird?.birdDescription;
			BirdDetails.text = bird?.genderInfo;
			OtherInfo.text = bird?.otherInfo;
			
			//load default no image image if there is none, else load image normaly
			if(bird?.image == nil){
				SetImageButton.setImage(UIImage(named: "IMG_NoImage"), for: .normal);
			}else{
				SetImageButton.setImage(bird?.image, for: .normal);
			}
			
			for locs in (bird?.locations)! {
				let annotation = MKPointAnnotation();
				annotation.coordinate = (locs?.loc)!;
				annotation.subtitle = locs?.date;
				MapView.addAnnotation(annotation);
			}
		}

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	//exit view via back button
	@IBAction func BackButton(_ sender: Any) {
		//needs to be different based on if we are editing or creating a new bird
		let isNavController = presentingViewController is UINavigationController;
		if isNavController {
			dismiss(animated: true, completion: nil);
		}else{
			if navigationController != nil {
				navigationController?.popViewController(animated: true);
			}else{
				print("view controllers messed up somewhere");
			}
		}
	}
	
	//MARK: - IMAGE SET
	
	@IBAction func SetImage(_ sender: UIButton) {
		//open image picker
		let imagePickerController = UIImagePickerController();
		imagePickerController.sourceType = .photoLibrary;
		imagePickerController.delegate = self;
		
		present(imagePickerController,animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		print("Image Picker Cancel");
		dismiss(animated: true, completion: nil);
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
			fatalError("Expected a dictinary containing an image, but was provided the following: \(info)")
		}
		print("Setting Image");
		//update image of the selected button
		SetImageButton?.setImage(selectedImage, for: .normal);
		dismiss(animated: true, completion: nil)
	}
	
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender);
		
		// Set-up the meal to be passed to MealTableViewController after the unwind segue.
		bird = BirdData(name: BirdName.text!, description: Description.text!, genderInfo: BirdDetails.text!, otherInfo: OtherInfo.text!);
		bird?.image = SetImageButton.image(for: .normal);
		
	}
	
	//MARK: - Keyboard
	
	/**
	* Called when 'return' key pressed. return NO to ignore.
	*/
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder();
		return true;
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		textView.resignFirstResponder();
	}
	
	func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
		textView.resignFirstResponder();
		return true;
	}

}
