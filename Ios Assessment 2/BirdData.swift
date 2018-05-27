//
//  BirdData.swift
//  Ios Assessment 2
//
//  Created by Macy on 6/5/18.
//  Copyright © 2018 James Owen. All rights reserved.
//

import Foundation

import MapKit;

//list of keys for storing data
struct PropertyKey{
	static let name = "Name";
	static let locations = "Locs";
	static let description = "Description";
	static let genderInfo = "GenderInfo";
	static let otherInfo = "OtherInfo";
	static let image = "Image";
	static let LdLocLat = "LDataLocLAT";
	static let LdLocLong = "LDataLocLONG";
	static let LdDate = "LDataDate";
}

//holds information about the location
class LocationData : NSObject,NSCoding  {
	func encode(with aCoder: NSCoder) {
		//need to store location in two parts because attempting to store CLLocationCoordinate2D crashes the app
		aCoder.encode(loc?.latitude, forKey: PropertyKey.LdLocLat);
		aCoder.encode(loc?.longitude, forKey: PropertyKey.LdLocLong);

		aCoder.encode(date, forKey: PropertyKey.LdDate);
	}
	
	required convenience init?(coder aDecoder: NSCoder) {
		//make sure we can load first
		guard let date = aDecoder.decodeObject(forKey: PropertyKey.LdDate) as? String else {
			print("Failed to decode element");
			return nil;
		}
		
		let lat = aDecoder.decodeObject(forKey: PropertyKey.LdLocLat) as? CLLocationDegrees;
		let long = aDecoder.decodeObject(forKey: PropertyKey.LdLocLong) as? CLLocationDegrees;
		
		self.init(date: date,loc: CLLocationCoordinate2D(latitude: lat!, longitude: long!));
	}
	
	init?(date : String, loc : CLLocationCoordinate2D){
		self.date = date;
		self.loc = loc;
	}
	
	var loc : CLLocationCoordinate2D?;
	var date = "";//todo: find date datatype
}

class BirdData : NSObject,NSCoding {
	
	// MARK: - SAVE/LOAD
	
	//where we are storing the data
	static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!;
	static let archiveURL = documentsDirectory.appendingPathComponent("BirdData");
	
	//save
	func encode(with aCoder: NSCoder) {
		aCoder.encode(name, forKey: PropertyKey.name);
		aCoder.encode(locations, forKey: PropertyKey.locations);
		aCoder.encode(birdDescription, forKey: PropertyKey.description);
		aCoder.encode(genderInfo, forKey: PropertyKey.genderInfo);
		aCoder.encode(otherInfo, forKey: PropertyKey.otherInfo);
		aCoder.encode(image, forKey: PropertyKey.image);
	}
	
	//load
	required convenience init?(coder aDecoder: NSCoder) {
		//make sure we can load
		guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
			print("Failed to decode element");
			return nil;
		}
		
		let locations = aDecoder.decodeObject(forKey: PropertyKey.locations) as? [LocationData?];
		let description = aDecoder.decodeObject(forKey: PropertyKey.description) as? String;
		let genderInfo = aDecoder.decodeObject(forKey: PropertyKey.genderInfo) as? String;
		let otherInfo = aDecoder.decodeObject(forKey: PropertyKey.otherInfo) as? String;
		let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage;
		
		self.init(name: name, description: description!, genderInfo: genderInfo!, otherInfo: otherInfo!);
		//these arnt included in the init function, so just add them afterwards
		self.locations = locations!;
		self.image = image;
	}
	
	// MARK: - Everything else
	
	var name : String;
	var locations = [LocationData?]();
	var birdDescription : String;
	var genderInfo : String;
	var otherInfo : String;
	var image : UIImage?;
	
	init?(name : String, description : String, genderInfo : String, otherInfo : String){
		self.name = name;
		self.birdDescription = description;
		self.genderInfo = genderInfo;
		self.otherInfo = otherInfo;
	}
}
