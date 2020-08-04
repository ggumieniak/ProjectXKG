//
//  AlertViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 29/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

class AlertViewModel: ObservableObject {
    @Published var description: String = ""
    @Published var disabledButton: Bool = false
    private var pauseTimer = 0
    func makeFiveMinutesIntervalUntilNextReport() {
        disabledButton = true
        DispatchQueue.main.async {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.pauseTimer += 1
                print("Czekamy juz \(self.pauseTimer) zanim bedziesz mogl nacisnac kolejny przycisk")
                if self.pauseTimer == 10 {
                    self.disabledButton = false
                    timer.invalidate()
                }
            }
        }
    }
}
