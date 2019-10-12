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
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<FavoriteImages>(fileName: "image.plist")

    private init() {}
}
