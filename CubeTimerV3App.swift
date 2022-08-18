//
//  CubeTimerV3App.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/11/22.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var selection: Int
    
    init(selection: Int) {
        self.selection = selection
    }
}

class AppThemeViewModel : ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = true
    @AppStorage("inspectTimerOn") var inspectTimer = true
    @AppStorage("scrambleLength") var scrambleLength = 25
    @AppStorage("inspectTimerLength") var inspectLength = 10
    @AppStorage("inspectSound") var inspectSound = true
}

class isTimerRunning : ObservableObject {
    @Published var timerRunning = false
    @Published var firstTap = true
}

class TrashEnabled : ObservableObject {
    @Published var isDeleting : Bool = false
}

var timerManager = TimerManager()

@main
struct CubeTimerV3App: App {
    @StateObject private var dataController = DataController()
    @ObservedObject var appState = AppState(selection: 0)
    @ObservedObject var appThemeViewModel = AppThemeViewModel()
    @ObservedObject var isTimerRunningObject = isTimerRunning()
    @ObservedObject var trashEnabled = TrashEnabled()
    
    var body: some Scene {
        WindowGroup {
            if appState.selection == 0 {
                    launchScreen()
                        .environmentObject(appState)
                        .preferredColorScheme(appThemeViewModel.isDarkMode ? .dark : .light)
            } else if appState.selection == 1 {
                    threeTabs()
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                        .environmentObject(timerManager)
                        .environmentObject(appState)
                        .environmentObject(appThemeViewModel)
                        .environmentObject(isTimerRunningObject)
                        .environmentObject(trashEnabled)
                        .preferredColorScheme(appThemeViewModel.isDarkMode ? .dark : .light)
                        .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.25)))

                }
            }
        }
}
