//
//  ParseManager.swift
//  FoodAppWithClosure
//
//  Created by Zahra Alizada on 01.05.24.
//
import UIKit

class ParseManager {
    
    var errorCallback: ((String) -> Void)?
    
        func loadMainMenu(fileName: String) -> [Menu]? {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                errorCallback?("Error: Couldn't find or load the \(fileName).json file.")
                return nil
            }
            
            do {
                let categories = try JSONDecoder().decode([Menu].self, from: data)
                return categories
            } catch {
                errorCallback?("Error: Couldn't decode data into categories: \(error.localizedDescription)")
                return nil
            }
        }
        
        func loadItems(forCategory fileName: String) -> [Food]? {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                errorCallback?("Error: Couldn't find or load the \(fileName).json file.")
                return nil
            }
            
            do {
                let menuItems = try JSONDecoder().decode([Food].self, from: data)
                return menuItems
            } catch {
                errorCallback?("Error: Couldn't decode data into menu items: \(error.localizedDescription)")
                return nil
            }
        }
}
