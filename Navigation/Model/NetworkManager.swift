//
//  NetworkManager.swift
//  Navigation
//
//  Created by Алексей Сердюк on 22.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation

enum AppConfiguration : String, CaseIterable {
    case first = "https://jsonplaceholder.typicode.com/todos/1"
    case second = "https://swapi.dev/api/planets/1"
}

struct SomeData {
    var data : String = ""
}

var HW1 = SomeData()
var HW2 = SomeData()

struct Planet : Codable {
    var name : String
    var rotationPeriod : String
    var orbitalPeriod : String
    var diameter : String
    var climate : String
    var gravity : String
    var terrain : String
    var surfaceWater : String
    var population : String
    var residents : [String]
    var films : [String]
    var created : String
    var edited : String
    var url : String
}

struct NetworkManager {
    static func request(for configuration: AppConfiguration) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)

        if let url = URL(string: configuration.rawValue) { // получаем url для запроса
            let task = urlSession.dataTask(with: url, completionHandler: { data, responce, error in

                if let parsedData = data { // разворачиваем опционал, проверяем полученные данные

                    if configuration == AppConfiguration.first {
                        let str = String(data: parsedData, encoding: .utf8) // преобразовываем полученные даные в строку

                        if let stringToSerilization = str { // разворачиваем опционал, проверяем полученные данные
                            let dataToSerilization = Data(stringToSerilization.utf8) // подготавливаем данные для преобразования в JSON

                            do {
                                if let json = try JSONSerialization.jsonObject(with: dataToSerilization, options: [] ) as? [String: Any] {
                                    if let title = json["title"] as? String {
                                        HW1.data = title
                                    }
                                }
                            } catch let error as NSError {
                                print("Failed to load: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let planet = try decoder.decode(Planet.self, from: parsedData)
                            HW2.data = planet.orbitalPeriod
                        }
                        catch let error {
                            print(error)
                        }
                    }

                }
            })
            task.resume()
        }
    }

}
