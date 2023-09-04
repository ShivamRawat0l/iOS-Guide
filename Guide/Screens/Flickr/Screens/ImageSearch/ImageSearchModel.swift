//
//  ImageSearchModel.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
//

import Foundation

struct ImageSearchModel  {
    var images : [(String,String)] = [];
    
    mutating func searchImages(searchText : String ) async {
        let data : FlickerClass? = await NetworkService.fetchJSON(url: FlickerAPI.searchAPI(searchText: searchText))
        guard let data else {
            print("Error Occurred while parsing images")
            return
        }
        self.images = data.photos.photo.map { photo in
            (photo.title, FlickerAPI.createPhotoURL(server: photo.server, id: photo.id, secret: photo.secret))
        }
    }
}
