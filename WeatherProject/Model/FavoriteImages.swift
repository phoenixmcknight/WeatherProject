//
//  FavoriteImages.swift
//  persistenceLab
//
//  Created by Phoenix McKnight on 9/30/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation

struct FavoriteImages:Codable {
    let tags:String?
    let favorites:Int?
    let likes:Int?
    let imageURL:String?
}
