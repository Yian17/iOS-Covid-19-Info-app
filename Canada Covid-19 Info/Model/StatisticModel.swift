//
//  StatisticModel.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-18.
//

import Foundation

/*
 "Country": "Switzerland",
     "CountryCode": "CH",
     "Lat": "46.82",
     "Lon": "8.23",
     "Confirmed": 20505,
     "Deaths": 666,
     "Recovered": 6415,
     "Active": 13424,
     "Date": "2020-04-04T00:00:00Z",
     "LocationID": "628d4f12-6ebe-4fa9-b046-77ff0b894a4e"
 */
class StatisticModel: Codable {
    
    let country: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}
