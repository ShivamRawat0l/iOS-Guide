//
//  FlickerAPI.swift
//  Guide
//
//  Created by Shivam Rawat on 04/09/23.
//

import Foundation

struct FlickerAPI  {
    static func searchAPI(searchText : String) -> String {
        "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=fccf8aaeac3e27b61065ed037d540f08&text=\(searchText)&per_page=10&format=json&nojsoncallback=1"
    }
    static func createPhotoURL(server : String , id: String ,secret: String, size : String = "m")  -> String {
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg"
    }
}
