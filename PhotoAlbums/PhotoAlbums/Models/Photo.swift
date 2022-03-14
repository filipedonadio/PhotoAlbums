//
//  Photo.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import Foundation

struct Photo: Codable, Identifiable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
