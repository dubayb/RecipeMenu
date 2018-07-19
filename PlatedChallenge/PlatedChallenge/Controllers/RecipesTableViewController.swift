//
//  RecipesTableViewController.swift
//  PlatedChallenge
//
//  Created by Bryan Dubay on 5/23/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RecipesTableViewController: UITableViewController {
    let reuseID = "RecipeCell"
    var recipes: [Recipe]?
    var menuID: Int!
    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        let spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        spinner.hidesWhenStopped = true
        self.view.addSubview(spinner)
        ApiClient.getRecipes(with: menuID) { (result) in
            spinner.stopAnimating()
            switch result {
            case .success(let recipes):
                self.recipes = recipes as? [Recipe]
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as! RecipeTableViewCell
        let recipe = recipes?[indexPath.row]
        cell.name?.text = recipe?.name
        cell.subTitle?.text = recipe?.description
    
        guard let imageURL = URL(string: (recipe?.image)!) else { return cell }
        
        cell.foodImageView?.af_setImage(withURL: imageURL)
        return cell
    }
    // MARK: UI
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{return UITableViewAutomaticDimension}
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{return UITableViewAutomaticDimension}

}
