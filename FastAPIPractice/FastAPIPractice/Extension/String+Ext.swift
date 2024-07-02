//
//  String+Ext.swift
//  FastAPIPractice
//
//  Created by 신승재 on 7/2/24.
//

import Foundation

extension String {
    func toDateWithZeroTime() -> String? {
        // 원래 날짜 형식
        let originalDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        // 목표 날짜 형식
        let targetDateFormat = "yyyy년 MM월 dd일 HH:mm"
        
        let formatter = DateFormatter()
        formatter.dateFormat = originalDateFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = formatter.date(from: self) {
            // 새로운 날짜 형식으로 변환
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: date)
            components.hour = 0
            components.minute = 0
            
            if let zeroTimeDate = calendar.date(from: components) {
                formatter.dateFormat = targetDateFormat
                return formatter.string(from: zeroTimeDate)
            }
        }
        return nil
    }
}

