//
//  Favorites.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class FavoritesVC:UIViewController {
    let cellID = "favorites"
    var favorites = [FavoriteImages]() {
        didSet {
            favoritesTableView.reloadData()
        }
    }
   lazy var favoritesTableView:UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.modalPresentationStyle = .currentContext
               tableViewConstraints()
               loadData()
    }
        
    
    func loadData() {
     try? favorites = ImagePersistenceHelper.manager.getPhoto()
    }
    func tableViewConstraints() {
        self.view.addSubview(favoritesTableView)
        self.favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
                  self.favoritesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                  self.favoritesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                  self.favoritesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                  self.favoritesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                }
}
extension FavoritesVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite = favorites[indexPath.row]
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: cellID) as! FavoritesTableViewCell
        
        cell.favoriteImages.image = UIImage(data: favorite.image)
        return cell
        
    }
    
    }
    

