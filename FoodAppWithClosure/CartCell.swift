//
//  CartCell.swift
//  FoodAppWithClosure
//
//  Created by Zahra Alizada on 30.04.24.
//

import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak private var photoImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: String, name: String, price: Double) {
        photoImage.image = UIImage(named: image)
        nameLabel.text = name
        priceLabel.text = "$\(price)"
    }
}
