//
//  threeTabs.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/22/22.
//

import SwiftUI

/* class trashEnabled : ObservableObject {
    @Published var isDeleting : Bool = false
} */

struct threeTabs: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var appState : AppState
    @EnvironmentObject var appThemeViewModel : AppThemeViewModel
    @EnvironmentObject var isTimerRunningObject : isTimerRunning
    @EnvironmentObject var trashEnabled : TrashEnabled
    
    //@ObservedObject var trash = trashEnabled()
    
    @State private var tabSelection: TabBarItem = .stopwatch
    @State var timerRunning = false
    @State var firstTap = true
    @State var scramble = ""
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            
            stopwatch(scramble: $scramble)
                .tabBarItem(tab: .stopwatch, selection: $tabSelection)
            
            mainStats()
                .tabBarItem(tab: .stats, selection: $tabSelection)
                .environmentObject(trashEnabled)
               // .environmentObject(trash)
            
            settings()
                .tabBarItem(tab: .settings, selection: $tabSelection)

        }
        .onAppear {
            scramble = generateThreeScramble(size: appThemeViewModel.scrambleLength)
        }
        .environmentObject(isTimerRunningObject)
        .environmentObject(trashEnabled)
    }
}

struct threeTabs_Previews: PreviewProvider {
    static let timerPreview = TimerManager()
    static let appThemeViewModel = AppThemeViewModel()
    static let appState = AppState(selection: 0)
    static let isTimerRunningObject = isTimerRunning()
    static let trashEnabled = TrashEnabled()
    
    static var previews: some View {
        threeTabs()
            .environmentObject(timerPreview)
            .environmentObject(appThemeViewModel)
            .environmentObject(appState)
            .environmentObject(isTimerRunningObject)
            .environmentObject(trashEnabled)
            .preferredColorScheme(.dark)
    }
}
