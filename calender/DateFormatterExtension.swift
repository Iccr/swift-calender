//
//  DateFormatterExtension.swift
//  calender
//
//  Created by shishir sapkota on 1/2/18.
//  Copyright © 2018 ccr. All rights reserved.
//

import Foundation

extension DateFormatter {
    class func stringFrom(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    class func DateFrom(string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)
    }
}

