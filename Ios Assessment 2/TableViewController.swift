//
//  TableViewController.swift
//  Ios Assessment 2
//
//  Created by Macy on 6/5/18.
//  Copyright © 2018 James Owen. All rights reserved.
//

import UIKit
import os.log
import MapKit;

//loads/saves and updates the cells
class TableViewController: UITableViewController {

	//list of our birds
	var m_Birds = [BirdData]();
	
    override func viewDidLoad() {
        super.viewDidLoad()

		//if we have birds to load then set them as our list
		if let birds = loadBirds() {
			m_Birds = birds;
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//quick exit
	@IBAction func BackButton(_ sender: Any) {
		dismiss(animated: true, completion: nil);
		
		
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return m_Birds.count;
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementIdentifier", for: indexPath) as? TableViewCell else {
			fatalError("Table view Dequeued cell is not correct cell");
		}

        // Configure the cell...
		
		let test = m_Birds[indexPath.row];
		
		cell.TitleTest.text = test.name;
		cell.DetailTest.text = "\(indexPath.row)";
		

        return cell;
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		super.prepare(for: segue, sender: sender);
		
		switch(segue.identifier ?? ""){
		case "AddItem":
			//no data to pass through
			print("Add item");
		case "ShowDetail":
			print("Show Item")
			//assume these are all casted correctly
			//get destination
			let birdViewController = segue.destination as? ElementViewController;

			//get BirdData reference
			let selectedCell = sender as? TableViewCell;
			let index = tableView.indexPath(for: selectedCell!);
			let selectedBird = m_Birds[(index?.row)!];

			//set destination's bird to selected bird
			birdViewController?.bird = selectedBird;
		case "SelectBirdLocation":
			print("Show Bird Location")
			//note: this destination has a static reference for it's bird

			//let locSetViewController = segue.destination as? LocationSetViewController;
			let selectedCell = sender as? TableViewCell;
			let index = tableView.indexPath(for: selectedCell!);
			let selectedBird = m_Birds[(index?.row)!];
			//locSetViewController?.bird = selectedBird;
			LocationSetViewController.bird = selectedBird;
		default:
			fatalError("Segue Error \(String(describing: segue.identifier))");
		}
		
    }

	
	
	@IBAction func unwindToBirdList(sender: UIStoryboardSegue) {
		print("unwind");

		//check if it's the LocationSet controller
		if sender.source is LocationSetViewController {
			//it's bird is static so handle it differntly 
			let bird = LocationSetViewController.bird;
			let selectedIndex = tableView.indexPathForSelectedRow;
			m_Birds[(selectedIndex?.row)!] = bird!;

			//no viewable data is added
			//tableView.reloadRows(at: [selectedIndex!], with: .none);
			print("Location updated bird");
			//finally save
			saveBirds();
			return;
		}
		
		//check if it's from ElementViewController and get it's bird
		if let sourceViewController = sender.source as? ElementViewController, let bird = sourceViewController.bird {
			
			//check to see if we need to add a new bird or update an existing one
			if let selectedIndex = tableView.indexPathForSelectedRow {
				//update
				m_Birds[selectedIndex.row] = bird;
				tableView.reloadRows(at: [selectedIndex], with: .none);
			}else{
				//add new bird
				let newIndexPath = IndexPath(row: m_Birds.count, section: 0)
				
				m_Birds.append(bird)
				tableView.insertRows(at: [newIndexPath], with: .automatic)
			}
			print("SAVED unwindToBirdList");
		}
		saveBirds();
	}
	
	// MARK: - SAVE/LOAD
	
	func saveBirds(){
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(m_Birds, toFile: BirdData.archiveURL.path);
		
		if isSuccessfulSave {
			print("Save succeed");
		}else{
			print("Save failed...");
		}	
		
	}
	
	func loadBirds() -> [BirdData]? {
		return NSKeyedUnarchiver.unarchiveObject(withFile: BirdData.archiveURL.path) as? [BirdData];
	}

}
