//
//  CartController.swift
//  FoodAppWithClosure
//
//  Created by Zahra Alizada on 29.04.24.
//

import UIKit

class CartController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        
        updateTrashButtonVisibility()
    }

    func updateTrashButtonVisibility() {
        if CartManager.shared.getItems().isEmpty {
            navigationItem.rightBarButtonItem = nil
        } else {
            let trashBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(trashTappedButton(_:)))
            trashBtn.image = UIImage(systemName: "trash")
            navigationItem.rightBarButtonItem = trashBtn
        }
    }
    
    @IBAction func trashTappedButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?",
                                      message: "Delete all items?",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive) { action in
                CartManager.shared.removeAll()
                self.updateTrashButtonVisibility()
                self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension CartController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CartManager.shared.getItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CartCell.self)", for: indexPath) as! CartCell
        let cartItems = CartManager.shared.getItems()[indexPath.row]
        cell.configure(image: cartItems.image ?? "", name: cartItems.name ?? "", price: cartItems.price ?? 0)
        return cell
    }
}

extension CartController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tableView.beginUpdates()
        CartManager.shared.removeItem(indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        self.tableView.endUpdates()
        updateTrashButtonVisibility()
    }
}
