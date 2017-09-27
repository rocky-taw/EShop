//
//  ListTableViewCell.swift
//  EShop
//
//  Created by Admin on 8/16/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    func bindData(item: ShoppingList) {
        
        let currentDateFormatter = dateFormatter()
        currentDateFormatter.dateFormat = "dd/MM/YYYY"
        
        let date = currentDateFormatter.string(from: item.date)
        
        self.nameLabel.text = item.name
        self.totalItemsLabel.text = "\(item.totalItems) Items"
        self.totalPriceLabel.text = "Total $ \(String(format: "%.2f", item.totalPrice))"
        self.dateLabel.text = date
        
        self.totalPriceLabel.sizeToFit()
        self.nameLabel.sizeToFit()
        
    }


}
