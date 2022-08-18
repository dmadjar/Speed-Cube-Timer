//
//  CustomTabBarContainerView.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/22/22.
//

import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
    @EnvironmentObject var isTimerRunningObject : isTimerRunning
    @EnvironmentObject var trashEnabled : TrashEnabled
   // @EnvironmentObject var trash : trashEnabled
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
                .environmentObject(isTimerRunningObject)
                .environmentObject(trashEnabled)
                //.environmentObject(trash)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .stopwatch, .stats, .settings
    ]
    
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
