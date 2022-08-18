//
//  tabBarItem.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/22/22.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    
    case stopwatch, stats, settings
    
    var iconName: String {
        switch self {
            case .stopwatch: return "clock"
            case .stats: return "chart.bar.xaxis"
            case .settings: return "gearshape"
        }
    }
    
    var title: String {
        switch self {
            case .stopwatch: return "Stopwatch"
            case .stats: return "Statistics"
            case .settings: return "Settings"
        }
    }
    
    var color: Color {
        switch self {
            case .stopwatch: return Color("orangeColor")
            case .stats: return Color("textColor")
            case .settings: return Color("greenColor")
        }
    }
}
