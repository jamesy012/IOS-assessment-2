//
//  LocationSetViewController.swift
//  Ios Assessment 2
//
//  Created by Macy on 27/5/18.
//  Copyright © 2018 James Owen. All rights reserved.
//

import UIKit
import MapKit;

class LocationSetViewController: UIViewController, CLLocationManagerDelegate {
	
	@IBOutlet weak var MapView: MKMapView!
	@IBOutlet weak var BirdName: UILabel!
	
	//static because it was nil after passing it through, and since there is only one at a time, static will be fine
	static var bird : BirdData?
	
	var locManager : CLLocationManager?;
	var currLoc : CLLocation?;
	
	var currAnnotation : MKPointAnnotation? = nil;
	
	var hasMovedMap = false;
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		locManager = CLLocationManager();
		locManager?.delegate = self;
		locManager?.requestWhenInUseAuthorization();
		locManager?.startUpdatingLocation();
		
		
		if(LocationSetViewController.bird != nil){
			BirdName.text = LocationSetViewController.bird?.name;
		}else{
			BirdName.text = "Error";
		}
		
		for locs in (LocationSetViewController.bird?.locations)! {
			let annotation = MKPointAnnotation();
			annotation.coordinate = (locs?.loc)!;
			annotation.subtitle = locs?.date;
			MapView.addAnnotation(annotation);
		}
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	
    // MARK: - Navigation

	
	@IBAction func BackButton(_ sender: Any) {
		dismiss(animated: true, completion: nil);
	}
	
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		
		let ld = LocationData(date: "Today", loc: (currLoc?.coordinate)!);//todo: change Today with a real date
		LocationSetViewController.bird?.locations += [ld];
		
		print("Prepare - Back");
    }

	
	//MARK: - Location Delegate
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print("yes");
		currLoc = locations.last;
		if !hasMovedMap {
			hasMovedMap = true;
			let region = MKCoordinateRegionMake((currLoc?.coordinate)!, MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1));
			MapView.setRegion(region, animated: true);
		}
		if currAnnotation == nil {
			currAnnotation = MKPointAnnotation();
			currAnnotation?.title = "Current Location";
			MapView.addAnnotation(currAnnotation!);
		
		}
		currAnnotation?.coordinate = (currLoc?.coordinate)!;
		
	}
	

}
