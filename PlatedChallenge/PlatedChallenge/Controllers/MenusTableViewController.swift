//
//  MenusTableViewController.swift
//  PlatedChallenge
//
//  Created by Bryan Dubay on 5/23/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import UIKit

class MenusTableViewController: UITableViewController {

    var menus : [Menu]?
    let reuseID = "MenuCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menus"
        loadMenuData()
    }
    func loadMenuData(){
        ApiClient.getMenus { (result) in
            switch result {
            case .success(let menus):
                self.menus = menus as? [Menu]
                self.tableView.reloadData()
                break
            case .failure:
                //alert user
                break
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menus?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        let menu = menus?[indexPath.row]
        cell.textLabel?.text = menu?.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = indexPath as AnyObject
        performSegueWithIdentifier(segueIdentifier: .recipesForMenu, sender: sender )
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue: segue) {
        case .recipesForMenu:
            let recipeVC = segue.destination as! RecipesTableViewController
            
            guard let indexPath = sender as? IndexPath, let menus = self.menus else { return }
            
            recipeVC.title = menus[indexPath.row].title! + " Recipes"
            recipeVC.menuID = menus[indexPath.row].id!
        }
    }
    

}


extension MenusTableViewController : SegueHandlerType{
    enum SegueIdentifier: String {
        case recipesForMenu
    }
}
