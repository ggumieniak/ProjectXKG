//
//  NotificationPusher.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 16/12/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationPusher {
    static func pushNotification(type:String){
        let content = UNMutableNotificationContent()
        
        switch type {
        case K.Firestore.Collection.Categories.localThreaten:
            content.title = "There are a new local threaten!"
        case K.Firestore.Collection.Categories.roadAccident:
            content.title = "There are a new road accident!"
        case K.Firestore.Collection.Categories.weather:
            content.title = "There are a new weather!"
        default:
            content.title = "There are a new threaten!"
        }
        content.body = "Check them!"
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID.init().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
