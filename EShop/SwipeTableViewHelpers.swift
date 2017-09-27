//
//  SwipeTableViewHelpers.swift
//  EShop
//
//  Created by Admin on 8/19/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import UIKit

enum ActionDescriptor {
    
    case buy, returnPurchace, trash
    
    func title() -> String? {
        
        switch self {
        case .buy: return "Buy"
        case .returnPurchace: return "Return"
        case .trash: return "Trash"
            
        }
        
    }
    
    
    func image() -> UIImage? {
        
        let name: String
        
        switch self {
        case .buy: name = "BuyFilled"
        case .returnPurchace: name = "ReturnFilled"
        case .trash: name = "Trash"
        
        }
        
        return UIImage(named: name)
        
    }
    
    
    var color: UIColor {
        
        switch self {
        case .buy, .returnPurchace: return .darkGray
        case .trash: return .red
            
        }
        
    }
    
}


func createSelectedBackgroundView() -> UIView {
    
    let view = UIView()
    view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    return view
    
    
}
