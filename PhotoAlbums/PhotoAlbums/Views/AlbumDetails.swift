//
//  AlbumDetails.swift
//  PhotoAlbums
//
//  Created by Filipe Donadio on 14/03/2022.
//

import SwiftUI

struct AlbumDetails: View {
    @EnvironmentObject var albumsViewModel: AlbumsViewModel
    let cachedAlbum: CachedAlbum
    
    var body: some View {
        List(albumsViewModel.photos) { photo in
            HStack {
                AsyncImage(url: URL(string: photo.thumbnailUrl)!, scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 100)
                .cornerRadius(4)
                
                Text(photo.title)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(cachedAlbum.wrappedTitle)")
        .toolbar {
            Button {
                albumsViewModel.updateFavorite(forAlbum: Int(cachedAlbum.id))
            } label: {
                Group {
                    if cachedAlbum.isFavorite {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }
                .foregroundColor(.red)
            }
        }.task {
            await albumsViewModel.fetchPhotos(forAlbum: cachedAlbum.id)
        }
    }
}

struct AlbumDetails_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetails(cachedAlbum: CachedAlbum())
    }
}
