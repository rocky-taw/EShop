//
//  ShGroceryItemTableViewCell.swift
//  EShop
//
//  Created by Admin on 8/22/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class GroceryItemTableViewCell: ShoppingItemTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.quantityBackgroundView.isHidden = true
        self.quantityLabel.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func bindData(item: GroceryItem) {
        
        self.nameLabel.text = item.name
        self.extraInfoLabel.text = item.info
        self.priceLabel.text = "$ \(String(format: "%.2f", item.price))"
        
        
        if item.info != "" {
            
            imageFromData(pictureData: item.image, withBlock: { (image) in
                
                self.itemImageView.image = image!.circleMasked
                
            })
            
        } else {
            
            let image = UIImage(named: "ShoppingCartEmpty")!.scaleImageToSize(newSize: itemImageView.frame.size)
            
            self.itemImageView.image = image.circleMasked
        }
        
    }

}
