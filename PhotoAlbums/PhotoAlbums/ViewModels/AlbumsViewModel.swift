//
//  AlbumsViewModel.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import Foundation

class AlbumsViewModel: ObservableObject {
    @Published var albums: [CachedAlbum] = []
    @Published var photos: [Photo] = []
    
    private let albumService: AlbumsService
    private let albumsStorage: AlbumsStorage
    
    init(albumService: AlbumsService, albumStorage: AlbumsStorage) {
        self.albumService = albumService
        self.albumsStorage = albumStorage
    }
    
    func downloadAlbums() async {
        do {
            let albumsResult = try await albumService.fetchAlbums()
            switch albumsResult {
            case .success(let albums):
                for album in albums {
                    albumsStorage.createAlbum(album: album)
                }
                albumsStorage.saveContext()
                
                await MainActor.run {
                    self.albums = albumsStorage.loadAlbums()
                }
            case .failure(let error):
                // TODO: Show error warning
                print("Error: \(error.localizedDescription)")
            }
        } catch {
            // TODO: Show error warning
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func fetchPhotos(forAlbum albumId: Int) async {
        do {
            let photosResult = try await albumService.fetchPhotos(albumId: albumId)
            switch photosResult {
            case .success(let photos):
                await MainActor.run {
                    self.photos = photos
                }
            case .failure(let error):
                // TODO: Show error warning
                print("Error: \(error.localizedDescription)")
            }
        } catch {
            // TODO: Show error warning
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updateFavorite(forAlbum id: Int) {
        if let album = albums.filter ({ $0.id == id }).first {
            albumsStorage.updateFavorite(cachedAlbum: album)
            objectWillChange.send()
        }
    }
}
