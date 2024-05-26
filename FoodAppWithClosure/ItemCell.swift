//
//  ItemCell.swift
//  FoodAppWithClosure
//
//  Created by Zahra Alizada on 27.04.24.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    var addCallback: (() -> Void)?

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var itemImage: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addTappedButton(_ sender: Any) {
        addCallback?()
    }
    
    func configure(name: String, image: String) {
        self.nameLabel.text = name
        self.itemImage.image = UIImage(named: image)
    }
}
