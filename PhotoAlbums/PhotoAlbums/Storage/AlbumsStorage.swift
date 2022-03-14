//
//  AlbumsStorage.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import CoreData
import Foundation

class AlbumsStorage {
    let container = NSPersistentContainer(name: "Albums")
    
    func loadAlbums() -> [CachedAlbum] {
        let request: NSFetchRequest<CachedAlbum> = CachedAlbum.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func isFavoriteAlbum(albumId: Int16) -> Bool {
        let context = container.viewContext
        let predicate = NSPredicate(format: "id == %i && isFavorite == %d", albumId, true)
        let request: NSFetchRequest<CachedAlbum> = CachedAlbum.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1

        do {
            let cachedAlbums = try context.fetch(request)
            if cachedAlbums.count == 1 {
                return true
            }
        } catch {
            return false
        }

        return false
    }
    
    func updateFavorite(cachedAlbum: CachedAlbum) {
        cachedAlbum.isFavorite.toggle()
        saveContext()
    }
    
    func createAlbum(album: Album) {
        let cachedAlbum = CachedAlbum(context: container.viewContext)
        cachedAlbum.id = Int16(album.id)
        cachedAlbum.userId = Int16(album.userId)
        cachedAlbum.title = album.title
        cachedAlbum.isFavorite = isFavoriteAlbum(albumId: Int16(album.id))
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
