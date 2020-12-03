//
//  StatisticViewModel.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-18.
//

import Foundation

class StatisticViewModel {
    
    var statisticModel: [StatisticModel] = []
    
    func fetchStatistic(completion: @escaping (Result<Void, Error>) -> Void) {
        
        JSONService().fetchStatistic { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                self.statisticModel = self.getPastSevenDateModel(model: data)
                print(self.statisticModel)
                completion(.success(()))
            }
        }
    }
    
    func getPastSevenDateModel(model: [StatisticModel]) -> [StatisticModel] {
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var dates = [String]()
        for _ in 1...7 {
            date = cal.date(byAdding: .day, value: -1, to: date)!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            dates.append(formatter.string(from: date) + "T00:00:00Z")
        }
        return model.filter { dates.contains($0.date) }.sorted{ $0.date > $1.date }        
    }
    
    func getNumOfItems() -> Int {
        return statisticModel.count
    }
    
    func getModel(indexPath: IndexPath) -> StatisticModel {
        return statisticModel[indexPath.row]
    }
}
