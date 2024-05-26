//
//  FoodController.swift
//  FoodAppWithClosure
//
//  Created by Zahra Alizada on 29.04.24.
//

import UIKit

class FoodController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedFood: Menu?
    var items = [Food]()
    let parseManager = ParseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        
        collectionView.register(UINib(nibName: "\(ItemCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ItemCell.self)")
        loadFoodItems()
    }
    
    func loadFoodItems() {
        parseManager.errorCallback = { error in
            self.showErrorAlert(message: error)
        }
        
        items = parseManager.loadItems(forCategory: selectedFood?.name ?? "") ?? []
        collectionView.reloadData()
    }
    
    func showErrorAlert(message: String) {
          let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
          present(alert, animated: true)
      }
}

extension FoodController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemCell.self)", for: indexPath) as! ItemCell
        let item = items[indexPath.row]
        cell.configure(name: item.name ?? "",
                       image: item.image ?? "" )
        cell.addCallback = {
            CartManager.shared.addItem(item)
            let alert = UIAlertController(title: "Success",
                                          message: "\(item.name ?? "") added to cart",
                                          preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        return cell
    }
}

extension FoodController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "\(FoodItemController.self)") as! FoodItemController
        controller.selectedFoodItem = items[indexPath.row]
        navigationController?.show(controller, sender: nil)
    }
}

extension FoodController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width/2 - 18, height: 170)
    }
}
