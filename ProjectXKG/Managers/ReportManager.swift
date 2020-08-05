//
//  ReportManager.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 04/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

// MARK: Initialization
class ReportManager {
    let reportStore = ReportStore()
    private var timer = Timer()
    private var counter:Int = 0
    private var pauseTimer = 360
}
// MARK: Methods
extension ReportManager {
    func downloadData() {
        reportStore.fetchData()
    }
    
    func downloadDataEvery5Minutes() {
        reportStore.fetchData()
        setUpAndRunTimer()
    }
    private func setUpAndRunTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1,target: self,selector: #selector(countPauseBetweenReport), userInfo: nil, repeats: true)
    }
    @objc private func countPauseBetweenReport() {
//        print("Uzytkownik wlasnie uruchomil licznik i wynosy: \(counter)")
        if counter < pauseTimer {
            counter+=1
        } else {
            reportStore.fetchData()
            counter = 0
        }
    }
}
