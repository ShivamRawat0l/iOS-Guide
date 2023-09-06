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
//
//  NetworkService.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
//

import Foundation


class NetworkService {
    static func fetchJSON<T: Decodable>(url: String, type : T.Type) async -> T? {
        do {
            var urlrequest =  URLRequest(url: URL(string:url)!)
            urlrequest.httpMethod = "GET"
            let (data, _) = try await URLSession.shared.data(for: urlrequest);
            
            do{
                let jsonData = try JSONDecoder().decode(T.self, from: data)
                print(jsonData)
                return jsonData
            }catch {
                print("Error \(error)")
            }
        }catch {
            print("Error occured NetworkService.fetchXML \(error)")
        }
        return nil;
    }
    
}
