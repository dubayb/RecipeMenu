//
//  RecipeTableViewCell.swift
//  PlatedChallenge
//
//  Created by Bryan Dubay on 5/23/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
