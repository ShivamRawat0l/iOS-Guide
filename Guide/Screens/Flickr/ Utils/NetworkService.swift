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
