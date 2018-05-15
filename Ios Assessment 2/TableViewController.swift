//
//  TableViewController.swift
//  Ios Assessment 2
//
//  Created by Macy on 6/5/18.
//  Copyright © 2018 James Owen. All rights reserved.
//

import UIKit
import os.log

class TableViewController: UITableViewController {

	var m_Birds = [BirdData]();
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		
		guard let test1 = BirdData(name: "one") else {
			fatalError("Unable to instantiate meal1");
		}
		guard let test2 = BirdData(name: "two") else {
			fatalError("Unable to instantiate meal2");
		}
		
		m_Birds += [test1, test2];
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func BackButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
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
		

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	
	@IBAction func unwindToMealList(sender: UIStoryboardSegue) {
		if let sourceViewController = sender.source as? ElementViewController, let bird = sourceViewController.bird {
			
			// Add a new meal.
			let newIndexPath = IndexPath(row: m_Birds.count, section: 0)
			
			m_Birds.append(bird)
			tableView.insertRows(at: [newIndexPath], with: .automatic)
			
			print("SAVED");
		}
	}

}
