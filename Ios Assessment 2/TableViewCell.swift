//
//  TableViewCell.swift
//  Ios Assessment 2
//
//  Created by Macy on 6/5/18.
//  Copyright © 2018 James Owen. All rights reserved.
//

import UIKit

//just a holder class for the table view cells
class TableViewCell: UITableViewCell {

	// MARK: - Elements

	@IBOutlet weak var TitleTest: UILabel!
	@IBOutlet weak var DetailTest: UILabel!

	// MARK: - Functions
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
