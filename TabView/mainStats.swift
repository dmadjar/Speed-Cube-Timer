//
//  mainStats.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/12/22.
//

import SwiftUI

struct mainStats: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var trashEnabled : TrashEnabled
    //@EnvironmentObject var trash: trashEnabled
    @State var tabSelection: Int = 1
    @State var statSelection: [String] = ["2x2 STATS", "3x3 STATS", "4x4 STATS"]
    @State var toggleTap: Bool = false
    
    var body: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea()
        
            GeometryReader { geo in
                    ZStack {
                        if tabSelection == 0 {
                            twoStats()
                                .environmentObject(trashEnabled)
                                .opacity(toggleTap ? 0.5 : 1)
                        } else if tabSelection == 1 {
                            threeStats()
                                .environmentObject(trashEnabled)
                                .opacity(toggleTap ? 0.5 : 1)
                        } else if tabSelection == 2 {
                            fourStats()
                                .environmentObject(trashEnabled)
                                .opacity(toggleTap ? 0.5 : 1)
                        }
                        
                    VStack {
                        Spacer()
                            .frame(height: geo.size.height / 8)
                        
                        switchStats(tabSelection: $tabSelection, statSelection: $statSelection)
 
                        Spacer()
                    }
                       
                }
            }
        }
    }
}

struct mainStats_Previews: PreviewProvider {
    
    static var trashEnabled = TrashEnabled()
    
    static var previews: some View {
        mainStats()
                .preferredColorScheme(.dark)
                .environmentObject(trashEnabled)
    }
}

struct switchStats: View {
    
    @Binding var tabSelection : Int
    @Binding var statSelection : [String]
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    var body: some View {
            VStack {
                Menu {
                    Button {
                        tabSelection = 2
                    } label : {
                        Text("4x4")
                    }
                    
                    Button {
                        tabSelection = 1
                    } label : {
                        Text("3x3")
                    }
                           
                    Button {
                      tabSelection = 0
                    } label : {
                        Text("2x2")
                    }
                } label: {
                    if tabSelection == 0 {
                    HStack {
                        Text(statSelection[tabSelection])
                            .font(.custom("Roboto-BlackItalic", size: width * 0.125))
                            .foregroundColor(Color("yellowColor"))
                        
                        Spacer()
                        
                        VStack(spacing: 2.5) {
                            Image(systemName: "chevron.down.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("yellowColor"))
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .frame(width: width, alignment: .bottomLeading)
                        
                    } else if tabSelection == 1 {
                        HStack {
                            Text(statSelection[tabSelection])
                                .font(.custom("Roboto-BlackItalic", size: width * 0.125))
                                .foregroundColor(Color("blueColor"))
                               
                            Spacer()
                            
                            VStack(spacing: 2.5) {
                                Image(systemName: "chevron.down.circle.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color("blueColor"))
                            }
                            
                        }
                        .padding(.horizontal, 20)
                        .frame(width: width, alignment: .bottomLeading)
                        
                        
                    } else {
                        HStack {
                            Text(statSelection[tabSelection])
                                .font(.custom("Roboto-BlackItalic", size: width * 0.125))
                                .foregroundColor(Color("greenColor"))
                            Spacer()
                            
                            VStack(spacing: 2.5) {
                                Image(systemName: "chevron.down.circle.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color("greenColor"))
                            }
                        }
                        .padding(.horizontal, 20)
                        .frame(width: width, alignment: .bottomLeading)
                    }
                    
            }
            
        }
        .frame(width: width, height: height / 15)
    }
}
