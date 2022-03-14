//
//  AlbumsService.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import Foundation

protocol AlbumsServiceable {
    func fetchAlbums() async throws -> Result<[Album], RequestError>
    func fetchPhotos(albumId: Int16) async throws -> Result<[Photo], RequestError>
}

class AlbumsService: HTTPClient, AlbumsServiceable {
    func fetchAlbums() async throws -> Result<[Album], RequestError> {
        try await sendRequest(endpoint: AlbumsEndpoint.albums, responseModel: [Album].self)
    }
    
    func fetchPhotos(albumId: Int16) async throws -> Result<[Photo], RequestError> {
        try await sendRequest(endpoint: AlbumsEndpoint.photos(albumId: albumId), responseModel: [Photo].self)
    }
}
