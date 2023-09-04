//
//  NetworkService.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
//

import Foundation

struct FlickerClass : Codable{
    struct Photo : Codable {
        var id : String;
        var owner : String;
        var title : String ;
        var secret : String ;
        var server : String ;
    }
    struct Photos : Codable{
        
        var page : Int;
        var pages :Int;
        var perpage : Int;
        var total : Int ;
        var photo : [Photo];
    }
    var photos : Photos;
}

class NetworkService {
    static func fetch<T: Decodable>(url : String, type: T) async -> T?  {
        do {
            let (data , _ ) =  try await URLSession.shared.data(from: URL(string: url)!)
            return try JSONDecoder().decode(T.self, from: data);
        }catch {
            print("Error occured NetworkService.fetch \(error)")
        }
        return nil;
    }
    
    static func fetchJSON (url: String) async -> FlickerClass? {
        do {
            var urlrequest =  URLRequest(url: URL(string:url)!)
            urlrequest.httpMethod = "GET"
            let (data, response) = try await URLSession.shared.data(for: urlrequest);
            do{
                let jsonData = try JSONDecoder().decode(FlickerClass.self, from: data)
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
