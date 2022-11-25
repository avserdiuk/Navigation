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

struct SomeStruct {
    let id : Int = 0
    let userId : Int = 0
    var title : String = ""
    let completed : Bool = false
}

var user = SomeStruct()

struct NetworkManager {
    static func request(for configuration: AppConfiguration) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)

        if let url = URL(string: configuration.rawValue) { // получаем url для запроса
            let task = urlSession.dataTask(with: url, completionHandler: { data, responce, error in

                if let parsedData = data { // разворачиваем опционал, проверяем полученные данные
                    let str = String(data: parsedData, encoding: .utf8) // преобразовываем полученные даные в строку

                    if let stringToSerilization = str { // разворачиваем опционал, проверяем полученные данные
                        let dataToSerilization = Data(stringToSerilization.utf8) // подготавливаем данные для преобразования в JSON

                        do {
                            if let json = try JSONSerialization.jsonObject(with: dataToSerilization, options: [] ) as? [String: Any] {
                                if let title = json["title"] as? String {
                                    user.title = title
                                }
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                        }
                    }
                }
            })
            task.resume()
        }
    }


    
}
