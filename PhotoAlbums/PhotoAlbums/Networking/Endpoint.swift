//
//  Endpoint.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
}
