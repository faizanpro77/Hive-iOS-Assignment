//
//  APIManager.swift
//  Hive-iOS-Assignment
//
//  Created by MD Faizan on 03/09/23.
//

import Foundation


class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func searchWikipedia(query: String, completionHandler: @escaping (_ data:[WikipediaSearchResult]?) -> ()) {
        
        var urlComponents = URLComponents(string: "https://en.wikipedia.org/w/api.php")
        
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "generator", value: "search"),
            URLQueryItem(name: "gsrnamespace", value: "0"),
            URLQueryItem(name: "gsrsearch", value: query),
            URLQueryItem(name: "gsrlimit", value: "10"),
            URLQueryItem(name: "prop", value: "pageimages|extracts"),
            URLQueryItem(name: "pilimit", value: "max"),
            URLQueryItem(name: "exintro", value: ""),
            URLQueryItem(name: "explaintext", value: ""),
            URLQueryItem(name: "exsentences", value: "1"),
            URLQueryItem(name: "exlimit", value: "max")
        ]
        
        // Add query items to the URL components
        urlComponents?.queryItems = queryItems
        
        if let urlString = urlComponents?.url?.absoluteString {
            
            
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
                    if let data = data, error == nil {
                        do {
                            
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(WikipediaSearchResultResponse.self, from: data)
                            
                            completionHandler(result.searchResults)
                        } catch {
                            print("Error parsing JSON: \(error)")
                            completionHandler(nil)
                        }
                    } else {
                        completionHandler(nil)
                        print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }.resume()
            }
        }
    }
    
}
