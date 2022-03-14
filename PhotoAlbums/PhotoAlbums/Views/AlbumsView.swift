//
//  AlbumsView.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import SwiftUI

struct AlbumsView: View {
    @EnvironmentObject var albumsViewModel: AlbumsViewModel
    
    var body: some View {
        NavigationView {
            List(albumsViewModel.albums) { album in
                NavigationLink {
                    AlbumDetails(cachedAlbum: album)
                } label: {
                    HStack {
                        if album.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }

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
            .navigationTitle("Albums")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            await albumsViewModel.downloadAlbums()
        }
    }
}

struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView()
    }
}
