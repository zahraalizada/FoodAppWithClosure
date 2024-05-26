//
//  HomeController.swift
//  FoodAppWithClosure
//
//  Created by Zahra Alizada on 27.04.24.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var foods = [Menu]()
    let parseManager = ParseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        collectionView.register(UINib(nibName: "\(ItemCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ItemCell.self)")
        
        let cartBtn = UIBarButtonItem(title: "", image: UIImage(systemName: "cart"), target: self, action: #selector(cartTappedButton(_:)))
        navigationItem.rightBarButtonItem = cartBtn
        loadMenu()
    }
    
    func loadMenu() {
        parseManager.errorCallback = { error in
            self.showErrorAlert(message: error)
        }
        
        foods = parseManager.loadMainMenu(fileName: "Menu") ?? []
        collectionView.reloadData()
     }
    
    func showErrorAlert(message: String) {
          let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
          present(alert, animated: true)
      }
    
    @IBAction func cartTappedButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "\(CartController.self)") as! CartController
        navigationController?.show(controller, sender: nil)
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemCell.self)", for: indexPath) as! ItemCell
        cell.configure(name: foods[indexPath.row].name ?? "", image: foods[indexPath.row].image ?? "")
        cell.addButton.isHidden = true
        return cell
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "\(FoodController.self)") as! FoodController
        controller.selectedFood = foods[indexPath.row]
        navigationController?.show(controller, sender: nil)
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 18, height: 170)
    }
}
