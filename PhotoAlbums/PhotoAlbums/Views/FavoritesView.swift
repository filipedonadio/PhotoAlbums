//
//  FavoritesView.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var albumsViewModel: AlbumsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if albumsViewModel.favorites.isEmpty {
                    VStack {
                        Spacer()
                        Text("Albums marked as favorite appear here.")
                        Spacer()
                    }
                } else {
                    List(albumsViewModel.favorites) { album in
                        NavigationLink {
                            AlbumDetails(cachedAlbum: album)
                        } label: {
                            HStack {
                                Text(album.wrappedTitle)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text("ID: \(album.id)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites ❤️")
        }
        .navigationViewStyle(.stack)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
