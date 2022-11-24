//
//  NetworkManager.swift
//  Navigation
//
//  Created by Алексей Сердюк on 22.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation

// Модель пользователя iosdt-2.1
struct UserModel {
    var title : String = ""
}

var jsonUser = UserModel()

enum AppConfiguration : String, CaseIterable {
    case first = "https://jsonplaceholder.typicode.com/todos/1"
    case second = "https://swapi.dev/api/starships/3"
    case third = "https://swapi.dev/api/planets/5"
}

struct NetworkManager {
    static func request(for configuration: AppConfiguration){
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)

        if let url = URL(string: configuration.rawValue) {
            let task = urlSession.dataTask(with: url, completionHandler: { data, responce, error in

                if let parsedData = data {
                    let str = String(data: parsedData, encoding: .utf8)

                    if let stringToSerilization = str {
                        let dataToSerilization = Data(stringToSerilization.utf8)

                        do {

                            if let json = try JSONSerialization.jsonObject(with: dataToSerilization, options: []) as? [String: Any] {
                                if let title = json["title"] as? String {
                                    jsonUser.title = title
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
