//
//  WeatherPersistence.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation

struct ImagePersistenceHelper {
    static let manager = ImagePersistenceHelper()

    func save(newImage: FavoriteImages) throws {
        try persistenceHelper.save(newElement: newImage)
    }

    func getPhoto() throws -> [FavoriteImages] {
        return try persistenceHelper.getObjects().sorted(by: {$0.date < $1.date})
    }
    
    func deleteFunction(withID: String) throws {
              do {
                  let photos = try getPhoto()
               let newPhotos = photos.filter { $0.date != withID }
                  try persistenceHelper.replace(elements: newPhotos)
              }
          }
    
    func replaceArray(favoritesArray:[FavoriteImages]) throws {
        try persistenceHelper.replace(elements: favoritesArray)
    }

    private let persistenceHelper = PersistenceHelper<FavoriteImages>(fileName: "image.plist")

    private init() {}
}
