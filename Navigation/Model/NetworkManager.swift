//
//  NetworkManager.swift
//  Navigation
//
//  Created by Алексей Сердюк on 22.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation

enum AppConfiguration : String {
    case first = "https://swapi.dev/api/people/8"
    case second = "https://swapi.dev/api/starships/3"
    case third = "https://swapi.dev/api/planets/5"

    static func randomUrl() -> AppConfiguration {
        let getRandom = [AppConfiguration.first, AppConfiguration.second, AppConfiguration.third]
        let index = Int(arc4random_uniform(UInt32(getRandom.count)))
        let url = getRandom[index]
        return url
    }
}

struct NetworkManager {
    static func request(for configuration: AppConfiguration) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)

        if let url = URL(string: configuration.rawValue) {
            let task = urlSession.dataTask(with: url, completionHandler: { data, responce, error in
                print("🍏 \(data)")
                print("🍏🍏 \(responce)")
                print("🍏🍏🍏 \(error)")
            })

            task.resume()
        }
    }
}
