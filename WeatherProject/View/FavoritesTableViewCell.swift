//
//  FavoritesTableViewCell.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/12/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

  lazy  var favoriteImages:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .center
        return imageview
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableViewConstraints() {
        self.contentView.addSubview(favoriteImages)
         self.favoriteImages.translatesAutoresizingMaskIntoConstraints = false
                      self.favoriteImages.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
                      self.favoriteImages.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
                      self.favoriteImages.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
                      self.favoriteImages.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
                    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
