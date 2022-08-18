//
//  DateFormatting.swift
//  SampleCoreData
//
//  Created by Federico on 18/02/2022.
//
import Foundation

// Formats the time since
func calcTimeSince(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if minutes == 1 {
        return "\(minutes) Min"
    } else if minutes < 120 {
        return "\(minutes) Mins"
    } else if minutes >= 120 && hours < 24 {
        return "\(hours) Hrs"
    } else {
        return "\(days) Days"
    }
}
