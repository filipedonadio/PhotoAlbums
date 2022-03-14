//
//  Album.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import Foundation

struct Album: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
}
