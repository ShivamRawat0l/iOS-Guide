//
//  ImageListViewModel.swift
//  Guide
//
//  Created by Shivam Rawat on 03/08/23.
//

import Foundation

class Remote : ObservableObject {
    @Published var imageList : [ImageList]? = nil;
    let imageUrl = URL(string: "https://picsum.photos/v2/list")
    
    
    func onLoad() {
        URLSession.shared.dataTask(with: imageUrl!) { data, response ,error in
            if let error {
                print("An Error Occured",error)
                return
            }
            if let data  {
                do {
                    let jsonData = try JSONDecoder().decode([ImageList].self, from: data)
                    DispatchQueue.main.async {
                        self.imageList = jsonData
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        self.imageList = []
                    }
                    print("Error Occured when decoding")
                }
            }
        }.resume()
    }
}
