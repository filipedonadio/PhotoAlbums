//
//  AlbumsEndpoint.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import Foundation

enum AlbumsEndpoint {
    case albums
    case photos(albumId: Int16)
}

extension AlbumsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .albums:
            return "albums"
        case .photos(let albumId):
            return "photos/?albumId=\(albumId)"
        }
    }
}
