//
//  DishCell.swift
//  FoodJournal
//
//  Created by Roberto Manese III on 7/7/19.
//  Copyright © 2019 jawnyawn. All rights reserved.
//

import UIKit

class DishCell: UITableViewCell {

    @IBOutlet var dishNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
    }

    func configure(dish: Dish) {
        dishNameLabel.text = dish.name
    }
    
}
