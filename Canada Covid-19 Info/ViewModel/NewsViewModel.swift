//
//  NewsViewModel.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-29.
//

import Foundation

class NewsViewModel {
    
    var newsModel: [News] = []
    
    func fetchNews(completion: @escaping (Result<Void, Error>) -> Void) {
        JSONService().fetchNews { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                self.newsModel = data.news
                completion(.success(()))
            }
        }
    }
    
    func numOfRows() -> Int {
        return newsModel.count
    }
    
    func getNews(indexPath: IndexPath) -> News {
        return newsModel[indexPath.row]
    }
}
