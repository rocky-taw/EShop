//
//  AddItemViewController.swift
//  EShop
//
//  Created by Admin on 8/19/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import KRProgressHUD

class AddItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var extraInfoTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    var shoppingList: ShoppingList!
    var shoppingItem: ShoppingItem?
    var groceryItem: GroceryItem?
    
    var addItemToList: Bool?
    
    var itemImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "ShoppingCartEmpty")!.scaleImageToSize(newSize: itemImageView.frame.size)
        
        itemImageView.image = image.circleMasked

        if shoppingItem != nil || groceryItem != nil {
            
            updateUI()
            
        }
        
    }

    // Mark: IBAction
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = Camera(delegate_ : self)
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert) in
        
            camera.PresentPhotoCamera(target: self, canEdit: true)
            //show camera
        
        }
        
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            
            camera.PresentPhotoLibrary(target: self, canEdit: true)
            //show library
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert) in
            
            
            
        }
        
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if nameTextField.text != "" && priceTextField.text != "" {
            
            if shoppingItem != nil || groceryItem != nil {
                
                self.updateItem()
                
            } else {
                
                saveItem()
                
            }
            
        } else {
            
            KRProgressHUD.showWarning(withMessage: "Empty Fields!")
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    // Mark: Saving Item
    
    func updateItem() {
        
        var imageData: String!
        
        if itemImage != nil {
            
            let image = UIImageJPEGRepresentation(itemImage!, 0.5)
            imageData = image?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            
        } else {
            
            imageData = ""
            
        }
        
        if shoppingItem != nil {
            
            shoppingItem!.name = nameTextField.text!
            shoppingItem!.info = extraInfoTextField.text!
            shoppingItem!.price = Float(priceTextField.text!)!
            shoppingItem!.quantity = quantityTextField.text!
            
            shoppingItem!.image = imageData
            
            shoppingItem!.updateItemInBackground(shoppingItem: shoppingItem!, completion: { (error) in
                
                if error != nil {
                    
                    KRProgressHUD.showError(withMessage: "Error updating item")
                    
                    return
                    
                }
            })
            
        } else if groceryItem != nil {
            
            groceryItem!.name = nameTextField.text!
            groceryItem!.info = extraInfoTextField.text!
            groceryItem!.price = Float(priceTextField.text!)!
            
            groceryItem!.image = imageData
            
            groceryItem!.updateItemInBackground(groceryItem: groceryItem!, completion: { (error) in
                
                if error != nil {
                    
                    KRProgressHUD.showError(withMessage: "Error updating item")
                    
                    return
                    
                }
            })
            
        }
        
    }
    
    func saveItem() {
        
        var shoppingItem: ShoppingItem
        
        var imageData: String!
        
        if itemImage != nil {
            
            let image = UIImageJPEGRepresentation(itemImage!, 0.5)
            imageData = image?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            
        } else {
            
            imageData = ""
            
        }
        
        
        if addItemToList! {
            
            // add to groceryList only
            shoppingItem = ShoppingItem(_name: nameTextField.text!, _info: extraInfoTextField.text!, _price: Float(priceTextField.text!)!, _shoppingListId: "")
            
            let groceryITem = GroceryItem(shoppingItem: shoppingItem)
            groceryITem.image = imageData
            
            groceryITem.saveItemInBackground(groceryItem: groceryITem, completion: { (error) in
            
                if error != nil {
                    KRProgressHUD.showError(withMessage: "Error saving grocery item")
                    return
                    
                }
            })
            
            self.dismiss(animated: true, completion: nil)
            
        } else {
            
            // add to current shopping list
            let shoppingItem = ShoppingItem(_name: nameTextField.text!, _info: extraInfoTextField.text!, _quantity: quantityTextField.text!, _price: Float(priceTextField.text!)!, _shoppingListId: shoppingList.id)
            
            shoppingItem.image = imageData
            
            shoppingItem.saveItemInBackground(shoppingItem: shoppingItem) { (error) in
                
                if error != nil {
                    
                    KRProgressHUD.showError(withMessage: "Error saving shopping item")
                    
                    return
                    
                }
            }
            
            showListNotification(shoppingItem: shoppingItem)
            
        }
        
    }
    
    func showListNotification(shoppingItem: ShoppingItem) {
        
    }
    
    // Mark: UIImagePickerController delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.itemImage = (info[UIImagePickerControllerEditedImage] as! UIImage)
        
        let newImage = itemImage!.scaleImageToSize(newSize: itemImageView.frame.size)
        self.itemImageView.image = newImage.circleMasked
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    // Mark: UpdateUI
    
    func updateUI() {
        
        if shoppingItem != nil {
            
            self.nameTextField.text = self.shoppingItem!.name
            self.extraInfoTextField.text = self.shoppingItem!.info
            self.quantityTextField.text = self.shoppingItem!.quantity
            self.priceTextField.text = "\(self.shoppingItem!.price)"
            
            if shoppingItem!.image != "" {
                
                imageFromData(pictureData: shoppingItem!.image, withBlock: { (image) in
                    
                    self.itemImage = image!
                    let newImage = image!.scaleImageToSize(newSize: itemImageView.frame.size)
                    self.itemImageView.image = newImage.circleMasked
                    
                })
                
            }
            
        } else if groceryItem != nil {
                
                self.nameTextField.text = self.groceryItem!.name
                self.extraInfoTextField.text = self.groceryItem!.info
                self.quantityTextField.text = ""
                self.priceTextField.text = "\(self.groceryItem!.price)"
                
                if groceryItem!.image != "" {
                    
                    imageFromData(pictureData: groceryItem!.image, withBlock: { (image) in
                        
                        self.itemImage = image!
                        let newImage = image!.scaleImageToSize(newSize: itemImageView.frame.size)
                        self.itemImageView.image = newImage.circleMasked
                        
                    })
                    
                }
        
        }
        
    }

}
