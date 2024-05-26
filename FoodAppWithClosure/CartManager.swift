//
//  Cart.swift
//  FoodAppWithClosure
//
//  Created by Zahra Alizada on 30.04.24.
//

import Foundation

class CartManager {
    static let shared = CartManager()

    private var items: [Food] = []

    private init() {}

    func addItem(_ item: Food) {
        items.append(item)
    }
    
    func getItems() -> [Food] {
            return items
    }
    
    func removeItem(_ index: Int) {
        items.remove(at: index)
    }
    
    func removeAll() {
        items.removeAll()
    }
}
