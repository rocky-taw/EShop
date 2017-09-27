//
//  GroceryItem.swift
//  EShop
//
//  Created by Admin on 8/22/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class GroceryItem {
    
    var name: String
    var info: String
    var price: Float
    var ownerId: String
    var image: String
    var groceryItemId: String
    
    
    init(_name: String,  _info: String = "", _price: Float, _image: String = "") {
        
        name = _name
        info = _info
        price = _price
        ownerId = "1234"
        image = _image
        groceryItemId = ""
        
    }
    
    init(dictionary: NSDictionary) {
        
        name = dictionary[kNAME] as! String
        info = dictionary[kINFO] as! String
        price = dictionary[kPRICE] as! Float
        ownerId = dictionary[kOWNERID] as! String
        image = dictionary[kIMAGE] as! String
        groceryItemId = dictionary[kGROCERYITEMID] as! String
        
    }
    
    
    init(shoppingItem: ShoppingItem) {
        
        name = shoppingItem.name
        info = shoppingItem.info
        price = shoppingItem.price
        ownerId = "1234"
        image = shoppingItem.image
        groceryItemId = ""
        
    }
    
    
    func dictionaryFromItem(item: GroceryItem) -> NSDictionary {
        
        return NSDictionary(objects: [item.name, item.info, item.price, item.ownerId, item.image, item.groceryItemId], forKeys: [kNAME as NSCopying, kINFO as NSCopying, kPRICE as NSCopying, kOWNERID as NSCopying, kIMAGE as NSCopying, kGROCERYITEMID as NSCopying])
        
    }
    
    
    func saveItemInBackground(groceryItem: GroceryItem, completion: @escaping(_ error: Error? ) -> Void){
        
        let ref = firebase.child(kGROCERYITEM).child("1234").childByAutoId()
        
        groceryItem.groceryItemId = ref.key
        
        ref.setValue(dictionaryFromItem(item: groceryItem)) { (error, ref) -> Void in
            completion(error)
        }
        
    }
    
    func updateItemInBackground(groceryItem: GroceryItem, completion: @escaping(_ error: Error? ) -> Void){
        
        let ref = firebase.child(kGROCERYITEM).child("1234").child(groceryItem.groceryItemId)
        
        ref.setValue(dictionaryFromItem(item: groceryItem)) { error, ref in
            
            completion(error)
        }
        
    }
    
    
    func deleteItemInBackground(groceryItem: GroceryItem){
        
        let ref = firebase.child(kGROCERYITEM).child("1234").child(groceryItem.groceryItemId)
        
        ref.removeValue()
        
    }
    
}
