//
//  ReportManager.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 04/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

class ReportManager {
    private var timer = Timer()
    private var counter:Int = 0
    private var pauseTimer = 300
    func makeFiveMinutesIntervalUntilNextReport() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1,target: self,selector: #selector(countPauseBetweenReport), userInfo: nil, repeats: true)
    }
    
    @objc func countPauseBetweenReport() {
        print("Uzytkownik wlasnie uruchomil licznik i wynosy: \(counter)")
        if counter < pauseTimer {
            counter+=1
        } else {
            timer.invalidate()
        }
    }
}
