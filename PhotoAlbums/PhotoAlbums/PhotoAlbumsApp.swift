//
//  PhotoAlbumsApp.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import SwiftUI

@main
struct PhotoAlbumsApp: App {
    @StateObject var albumsViewModel = AlbumsViewModel(albumService: AlbumsService(), albumStorage: AlbumsStorage())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(albumsViewModel)
                .alert("Error", isPresented: $albumsViewModel.showingError) {
                    Button("OK") { }
                } message: {
                    Text("Something went wrong. Please try again later.")
                }
        }
    }
}
