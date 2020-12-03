//
//  JSONService.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-18.
//

import Foundation

enum RequestError: Error {
    case urlError
    case noData
    case decodeError
    case retrieveError
    case storageError
    case noCachedDataError
}

class JSONService {
    
    struct Constant {
        static let statisticEndpoint = "https://api.covid19api.com/total/country/canada"
        static let newsEndpoint = "https://api.currentsapi.services/v1/search?"
        static let newsApiKey = "wNLmvEmvww02fuNSBysSRu3N8umEQ12CF4abRPPmq6A4dviy"
        static let cacahName = "NewsCache"
    }
    
    private let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request<T:Decodable> (url: URL, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(RequestError.noData))
                return
            }
            do {
                let dataObject = try JSONDecoder().decode(modelType.self, from: data)
                completion(.success(dataObject))
            } catch {
                completion(.failure(RequestError.decodeError))
            }
        }.resume()
        
    }
    
    func fetchStatistic(completion: @escaping (Result<[StatisticModel], Error>) -> Void) {
        
        guard let url = URL(string: Constant.statisticEndpoint) else {
            completion(.failure(RequestError.urlError))
            return
        }
        
        request(url: url, modelType: [StatisticModel].self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func fetchNews(completion: @escaping (Result<NewsModel, Error>) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            if CacheStorage.fileExists(Constant.cacahName, in: .caches) {
//                completion(.success(CacheStorage.))
                let newsModel = CacheStorage.retrieve(Constant.cacahName, from: .caches, as: NewsModel.self)
                completion(.success(newsModel))
            } else {
                completion(.failure(RequestError.noCachedDataError))
            }
            
        }
        
        let urlString = Constant.newsEndpoint + "keywords=covid&language=en&apiKey=" + Constant.newsApiKey
        
        guard let url = URL(string: urlString) else {
            completion(.failure(RequestError.urlError))
            return
        }
        
        request(url: url, modelType: NewsModel.self) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
//                completion(.success(data))
                CacheStorage.store(data, to: .caches, as: Constant.cacahName, success: {
                    completion(.success(data))
                }, failure: {error in
                    completion(.failure(RequestError.storageError))
                })
            }
        }
    }
    
//    func fetchStatistic(completion: @escaping (Result<[StatisticModel], Error>) -> Void) {
//        guard let url = URL(string: StatisticConstant.endpoint) else {
//            completion(.failure(RequestError.urlError))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        urlSession.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(RequestError.noData))
//                return
//            }
//            do {
//                let dataObject = try JSONDecoder().decode([StatisticModel].self, from: data)
//                completion(.success(dataObject))
//            } catch {
//                completion(.failure(RequestError.decodeError))
//            }
//        }.resume()
//
//    }
}
