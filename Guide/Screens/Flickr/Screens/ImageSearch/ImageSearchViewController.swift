//
//  ImageSearchViewController.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
//

import Foundation

@MainActor class ImageSearchViewController : ObservableObject  {
    @Published var images : [(String,String)] = [];
    @Published var imageURL : String?;
    @Published var imageID : String?;
    
    func fetchImages(searchText : String ) async {
        let data : FlickerClass? = await NetworkService.fetchJSON(url: FlickerAPI.searchAPI(searchText: searchText), type: FlickerClass.self)
        guard let data else {
            print("Error Occurred while parsing images")
            return
        }
        self.images = data.photos.photo.map { photo in
            (photo.title, FlickerAPI.createPhotoURL(server: photo.server, id: photo.id, secret: photo.secret))
        }
    }
}
