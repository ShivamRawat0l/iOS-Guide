//
//  ImageSearchViewController.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
//

import Foundation

class ImageSearchViewController : ObservableObject  {
    @Published var imageSearchModel = ImageSearchModel();
    
    func fetchImages(searchText: String) async  {
        await  imageSearchModel.searchImages(searchText: searchText)
    }
}
