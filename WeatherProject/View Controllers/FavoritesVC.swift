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
   private let cellID = "favorites"
   //MARK: Variables - Instances of Structs
    var favorites = [FavoriteImages]() {
        didSet {
            favoritesTableView.reloadData()
        }
    }
    //MARK:Variables - Outlets
    
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
       dismiss(animated: true, completion: nil)
        
    }
        
    
   
    
    //MARK: Functions - Constraints
    
    func tableViewConstraints() {
        self.view.addSubview(favoritesTableView)
        self.favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
                  self.favoritesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                  self.favoritesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                  self.favoritesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                  self.favoritesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                }
   //MARK: Functions - Miscellaneous
    func loadData() {
        try? favorites = ImagePersistenceHelper.manager.getPhoto()
           if favorites.count == 0 {
               checkIfAnythingHasBeenFavorited()
           } else {
               introPopUpAlert()

           }
       }
    
    func introPopUpAlert() {
        let alert = UIAlertController(title: "Favorites List", message: "Click Photo To Remove", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert,animated: true)
    }
}

//MARK: Extensions

extension FavoritesVC:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite = favorites[indexPath.row]
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: cellID) as! FavoritesTableViewCell
        cell.changeColorOfBorderCellFunction = {
            CustomLayer.shared.createCustomlayer(layer: cell.layer)
        }
        cell.changeColorOfBorderCellFunction()
        cell.layer.cornerRadius = 0
        cell.favoriteImages.image = UIImage(data: favorite.image)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionSheet(tag: indexPath.row)
       
    }
    
 
    }
extension FavoritesVC:CellDelegate {
    func actionSheet(tag: Int) {
           
             let alert = UIAlertController(title: "Options", message: "Choose Option", preferredStyle: .actionSheet)
             let delete = UIAlertAction(title: "Delete", style: .destructive) { (actions) in
               
                let currentPhoto = self.favorites[tag].date
                try? ImagePersistenceHelper.manager.deleteFunction(withID: currentPhoto)
                self.favorites.remove(at: tag)
                print(self.favorites.count)
                
                

            
                
                 
             }
             let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
             alert.addAction(delete)
             alert.addAction(cancel)
             present(alert,animated: true)
         
    }
    
    func checkIfAnythingHasBeenFavorited() {
        let alert = UIAlertController(title: "You cannot access this page", message: "Please favorite a photo to access the Favorites tab", preferredStyle: .alert)
        let dismissAlert = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
            self.tabBarController?.selectedIndex = 0
            
        }
            alert.addAction(dismissAlert)
        present(alert,animated: true)
       
    }
    }

    

