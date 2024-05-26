//
//  FoodItemController.swift
//  FoodAppWithClosure
//
//  Created by Zahra Alizada on 29.04.24.
//

import UIKit

class FoodItemController: UIViewController {
    
    @IBOutlet weak private var itemImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    
    var selectedFoodItem: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItem()
    }
    
    func setItem() {
        itemImage.image = UIImage(named: selectedFoodItem?.image ?? "")
        nameLabel.text = selectedFoodItem?.name
        descriptionLabel.text = selectedFoodItem?.description
        priceLabel.text = "\(selectedFoodItem?.price ?? 0)"
    }
}
