//
//  launchScreen.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 7/2/22.
//

import SwiftUI

struct launchScreen: View {
    @EnvironmentObject var appState : AppState
    
    @State private var isAnimated = false
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Color("backgroundColor").ignoresSafeArea()
                
                VStack {
                    Spacer()
                        .frame(width: geo.size.width, height: geo.size.height * 0.4)
                    
                    HStack(spacing: 5) {
                        Text("SPEED!")
                            .foregroundColor(Color("textColor"))
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.195))
                            .onAppear {
                                changeScreen()
                                self.isAnimated.toggle()
                            }
        
                        CubeAnimation()
                            .frame(width: 100, height: 100)
                            .rotationEffect(Angle.degrees(isAnimated ? 1800: 0))
                            .animation(.easeInOut(duration: 2), value: isAnimated)
                    }
                    .frame(width: geo.size.width)
                    
                    Spacer()
                      
                }
            }
        }
    }
    
    func changeScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              appState.selection = 1
        }
    }
}

struct launchScreen_Previews: PreviewProvider {
    static let appState = AppState(selection: 0)
    
    static var previews: some View {
        launchScreen()
            .environmentObject(appState)
    }
}
