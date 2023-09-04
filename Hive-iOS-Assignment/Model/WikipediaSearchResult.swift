//
//  WikipediaSearchResult.swift
//  Hive-iOS-Assignment
//
//  Created by MD Faizan on 03/09/23.
//

import Foundation

struct WikipediaSearchResultResponse: Codable {
    let query: Query
    
    var searchResults: [WikipediaSearchResult] {
        return query.pages.map { $0.value }
    }
}

struct Query: Codable {
    let pages: [String: WikipediaSearchResult]
}


struct WikipediaSearchResult: Codable {
    let title: String?
    private let thumbnail: Thumbnail?
    let extract: String?
    var imageUrlString: String? {
        thumbnail?.source
    }
}

struct Thumbnail: Codable {
    let source: String?
}
