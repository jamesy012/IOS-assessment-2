//
//  BirdData.swift
//  Ios Assessment 2
//
//  Created by Macy on 6/5/18.
//  Copyright © 2018 James Owen. All rights reserved.
//

import Foundation

import MapKit;

struct LocationData {
	var loc : CLLocationCoordinate2D;
	var date = "";//todo: find date datatype
}

class BirdData {
	
	var name : String;
	var locations = [LocationData]();
	var description : String;
	var genderInfo : String;
	var otherInfo : String;
	var image : UIImage?;
	
	init?(name : String, description : String, genderInfo : String, otherInfo : String){
		self.name = name;
		self.description = description;
		self.genderInfo = genderInfo;
		self.otherInfo = otherInfo;
	}
}
