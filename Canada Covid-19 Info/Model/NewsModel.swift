//
//  NewsModel.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-23.
//

import Foundation

struct NewsModel: Codable {
    let status: String
    let news: [News]
}
