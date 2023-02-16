//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Алексей Сердюк on 16.02.2023.
//  Copyright © 2023 aserdiuk. All rights reserved.
//

import Foundation
import UserNotifications


class LocalNotificationsService {

    let center = UNUserNotificationCenter.current()

    func registeForLatestUpdatesIfPossible(){
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { success, error in
            if let error = error {
                print("🎄\(error)")
            } else {
                print("🎄🎄\(success)")

                let content = UNMutableNotificationContent()
                content.title = "Посмотрите последние обновления"
                content.badge = 1
                content.sound = .default

                var component = DateComponents()
                component.hour = 19

                let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                self.center.add(request)
            }
        }
    }
}
