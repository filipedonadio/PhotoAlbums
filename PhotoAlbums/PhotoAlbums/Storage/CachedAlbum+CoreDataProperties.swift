//
//  CachedAlbum+CoreDataProperties.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//
//

import Foundation
import CoreData


extension CachedAlbum {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedAlbum> {
        return NSFetchRequest<CachedAlbum>(entityName: "CachedAlbum")
    }

    @NSManaged public var id: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var title: String?
    @NSManaged public var userId: Int16

    var wrappedTitle: String {
        title ?? "Unknown title"
    }
}

extension CachedAlbum : Identifiable {

}
