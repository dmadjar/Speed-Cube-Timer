//
//  settings.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/14/22.
//

import SwiftUI

struct settings: View {
    @EnvironmentObject var appThemeViewModel : AppThemeViewModel
    
    var body: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    Spacer()
                        .frame(width: geo.size.width, height: geo.size.height * 0.075)
                    
                    Group {
                        Text("SETTINGS")
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.125))
                            .foregroundColor(Color("greenColor"))
                            .frame(width: geo.size.width * 0.9, alignment: .leading)
                        
                        
                        Toggle("Enable Dark Mode", isOn: $appThemeViewModel.isDarkMode)
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.05))
                            .frame(width: geo.size.width * 0.9, alignment: .leading)
                        
                        Spacer()
                            .frame(width: geo.size.width, height: geo.size.height * 0.065)
                        
                        Toggle("Inspect Sound", isOn: $appThemeViewModel.inspectSound)
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.05))
                            .frame(width: geo.size.width * 0.9, alignment: .leading)
                        
                        Spacer()
                            .frame(width: geo.size.width, height: geo.size.height * 0.065)
                        
                        Toggle("Inspect Timer Enabled", isOn: $appThemeViewModel.inspectTimer)
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.05))
                            .frame(width: geo.size.width * 0.9, alignment: .leading)
                        
                    }
                    
                    Spacer()
                        .frame(width: geo.size.width, height: geo.size.height * 0.065)
                    
                    HStack {
                        Text("Inspect Timer Length")
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.05))
                        
                        Spacer()
                        
                        Text("\(appThemeViewModel.inspectLength)")
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.05))
                        
                        Stepper("", value: $appThemeViewModel.inspectLength, in: 5...15)
                            .frame(width: geo.size.width * 0.25)
                    }
                    .frame(width: geo.size.width * 0.9)
                    .opacity(appThemeViewModel.inspectTimer ? 1 : 0.3)
                    .disabled(!appThemeViewModel.inspectTimer)
                    
                    Spacer()
                        .frame(width: geo.size.width, height: geo.size.height * 0.065)
                    
                    HStack {
                        Text("Scramble Size")
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.05))
                        
                        Spacer()
                        
                        Text("\(appThemeViewModel.scrambleLength)")
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.05))
                        
                        Stepper("", value: $appThemeViewModel.scrambleLength, in: 10...30)
                            .frame(width: geo.size.width * 0.25)
                    }
                    .frame(width: geo.size.width * 0.9)
                }
                
            }
        }
    }
}

struct settings_Previews: PreviewProvider {
    static let appThemeViewModel = AppThemeViewModel()
    
    static var previews: some View {
            settings()
                .environmentObject(appThemeViewModel)
                .preferredColorScheme(.light)
    }
}
