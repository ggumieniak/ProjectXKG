//
//  ReportManager.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 04/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

// MARK: Initialization
class ReportManager {
    private let reportStore = ReportStore()
    private var timer = Timer()
    private var counter:Int = 0
    private var pauseTimer = 360
    private var data: [Report]?
}
//MARK: Accesors
extension ReportManager {
    func getReportAnnotations() -> [MKAnnotation] {
        
        return [MKAnnotation]()
    }
}

// MARK: Fetch data
extension ReportManager {
    func downloadData() {
        reportStore.fetchData()
    }
    
    func downloadDataTest() {
        print("downloadDataTest")
        reportStore.fetchData { reports in
            print("In arrary is: \(reports.count) of data")
            self.data = FirebaseDataClassifier(from: reports).getDataToShow()
            //
            print("Actuallu had that ammount of reports, that was fit to me \(String(describing: self.data?.count))")
            for report in reports
            {
                let item = report.data()
                // TODO: Adds the constants instead of String
                print("Opis: \(String(describing: item[K.Firestore.Categories.Fields.description]))\nCzas zdarzenia: \(String(describing: item[K.Firestore.Categories.Fields.date]))")
            }
        }
    }
    
    func downloadDataEvery5Minutes() {
        reportStore.fetchData()
        setUpAndRunTimer()
    }
}
// MARK: Utils
extension ReportManager {
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

