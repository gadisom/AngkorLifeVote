//
//  CountDownViewModel.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/28/25.
//

import SwiftUI
import Combine

final class CountDownViewModel: ObservableObject {
    @Published var days: String = "00"
    @Published var hours: String = "00"
    @Published var minutes: String = "00"
    @Published var seconds: String = "00"
    
    private var timer: Timer?
    private let targetDate: Date = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul") ?? .current
        return calendar.date(from: DateComponents(year: 2025, month: 2, day: 3)) ?? Date()
    }()
    
    init() {
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateCountdown()
        }
        updateCountdown()
    }

    private func updateCountdown() {
        let now = Date()
        let diff = targetDate.timeIntervalSince(now)
        
        if diff <= 0 {
            days = "00"
            hours = "00"
            minutes = "00"
            seconds = "00"
            timer?.invalidate()
            timer = nil
            return
        }
        
        let day = Int(diff / 86400)
        let hour = Int(diff.truncatingRemainder(dividingBy: 86400) / 3600)
        let minute = Int(diff.truncatingRemainder(dividingBy: 3600) / 60)
        let second = Int(diff.truncatingRemainder(dividingBy: 60))
        
        withAnimation(.easeInOut(duration: 0.3)) {
            days = String(format: "%02d", day)
            hours = String(format: "%02d", hour)
            minutes = String(format: "%02d", minute)
            seconds = String(format: "%02d", second)
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
