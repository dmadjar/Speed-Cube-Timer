//
//  CustomTabView.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/22/22.
//

import SwiftUI

struct CustomTabBarView: View {
    @EnvironmentObject var isTimerRunningObject : isTimerRunning
    @EnvironmentObject var trashEnabled : TrashEnabled
   // @EnvironmentObject var trash : trashEnabled
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    
    var body: some View {
        tabBarVersion1
            .onChange(of: selection, perform: { value in
                withAnimation(.easeInOut) {
                    localSelection = value
                }
                
                trashEnabled.isDeleting = false
              //  trash.isDeleting = false
            })
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static let timerRunning = isTimerRunning()
    static let trashEnabled = TrashEnabled()
    static let tabs: [TabBarItem] = [
        .stopwatch, .stats, .settings
    ]
    
    static var previews: some View {
        VStack {
            Spacer()
            
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
                .environmentObject(timerRunning)
                .environmentObject(trashEnabled)
        }
    }
}


extension CustomTabBarView {
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .hidden(!isTimerRunningObject.firstTap || isTimerRunningObject.timerRunning)
        }
        .opacity(localSelection == tab ? 1 : 0.15)
        .foregroundColor(localSelection == tab ? tab.color : .gray)
        .frame(maxWidth: .infinity)
        .cornerRadius(10)
    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .background(Color("backgroundColor").ignoresSafeArea(edges: .bottom))
    }
    
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
}

extension CustomTabBarView {
    
    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.custom("Roboto-Black", size: 20))
        }
        .opacity(localSelection == tab ? 1 : 0.15)
        .foregroundColor(localSelection == tab ? tab.color : Color(.gray))
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private var tabBarVersion2: some View {
        HStack(alignment: .bottom) {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
