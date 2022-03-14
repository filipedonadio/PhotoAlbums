//
//  ContentView.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AlbumsView()
                .tabItem {
                    Label("Albums", systemImage: "list.dash")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
