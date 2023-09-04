//
//  MainViewControllerViewModel.swift
//  Hive-iOS-Assignment
//
//  Created by MD Faizan on 03/09/23.
//

import Foundation

final class MainViewControllerViewModel {
    
    var reload:(()->())? = nil
    var searchResults: [WikipediaSearchResult] = []
    
    
    func searchWikipedia(query: String) {
        APIManager.shared.searchWikipedia(query: query) { [weak self] result in
            self?.searchResults = result ?? []
            // Update search results on the main thread
            DispatchQueue.main.async {
                self?.reload?()
            }
        }
    }
}
