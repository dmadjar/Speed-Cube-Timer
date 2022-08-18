//
//  threeStats.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/11/22.
//

import SwiftUI
import CoreData

struct fourStats: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var fourSolves: FetchedResults<FourSolve>
    
    var sumTime : Double {
        fourSolves.reduce(0) { $0 + $1.timeDouble }
    }
    
    var runningAvg : Double {
        sumTime / Double(fourSolves.count)
    }
    
    @State var firstClick = true
    @EnvironmentObject var trashEnabled: TrashEnabled
   // @EnvironmentObject var trash: trashEnabled
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor").ignoresSafeArea()
            
                VStack {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height / 15)
                    
                        Text("Solve Count: \(fourSolves.count)")
                            .font(.custom("Roboto-Black", size: UIScreen.main.bounds.width / 22))
                            .frame(width: UIScreen.main.bounds.width / 1.2, alignment: .leading)
                            
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height / 25)
                        
                        Text(fourSolves.count == 0 ? "Running Average: No Solves" : "Running Average: \(timerManager.getFormatedTime(seconds: runningAvg))")
                                .font(.custom("Roboto-Black", size: UIScreen.main.bounds.width / 22))
                                .frame(width: UIScreen.main.bounds.width / 1.2, alignment: .leading)
                    
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height / 25)
                    
                    Text("Best Time: \(timerManager.getFormatedTime(seconds: lowestTime()))")
                        .font(.custom("Roboto-Black", size: UIScreen.main.bounds.width / 22))
                        .frame(width: UIScreen.main.bounds.width / 1.2, alignment: .leading)
                    
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height / 25)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("greenColor"))
                            .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 2.75)
                            .shadow(color: Color.black.opacity(0.4), radius: 6, x: 5, y: 5)
                        
                        VStack(spacing: 3) {
                            HStack {
                                Text("Date")
                                    .font(.custom("Roboto-Black", size: UIScreen.main.bounds.width / 21))
                                
                                Spacer()
                                
                                Text("Time")
                                    .font(.custom("Roboto-Black", size: UIScreen.main.bounds.width / 21))
                            }
                            .padding(.horizontal, 7.5)
                            .frame(width: UIScreen.main.bounds.width / 1.25)
                    
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color("darkGreen").opacity(0.25))
                                .frame(width: UIScreen.main.bounds.width / 1.25, height: 3)

                    ScrollView {
                        ForEach(fourSolves) { solve in
                            NavigationLink(destination: scrambleDisplay(scramble: solve.scramble!, time: solve.timeString!, color: Color("greenColor"))) {
                                VStack {
                                    Spacer()
                                        .frame(height: 15)
                                    
                                    HStack {
                                            Text("\(calcTimeSince(date: solve.date!))")
                                            .foregroundColor(Color("blackandwhite"))
                                                .font(.custom("Roboto-Black", size: UIScreen.main.bounds.width / 23))
                                                .frame(height: 30)
                                        
                                            Spacer()
                                                    
                                            Text(solve.timeString!)
                                                .foregroundColor(Color("blackandwhite"))
                                                .font(.custom("Roboto-Black", size: UIScreen.main.bounds.width / 23))
                                                .frame(height: 30)
                                            
                                        
                                            if trashEnabled.isDeleting {
                                                Button(action: {
                                                    if let index = fourSolves.firstIndex(of: solve) {
                                                        self.deleteSolve(at: IndexSet(integer: index))
                                                    }
                                                }) {
                                                    Image(systemName: "multiply")
                                                        .foregroundColor(Color("darkGreen"))
                                                        .frame(height: 30)
                                                    }
                                            } else {
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor( Color("darkGreen"))
                                                    .frame(height: 30)
                                            }
                                        }
                                    .frame(width: UIScreen.main.bounds.width / 1.3)
                                    
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color("darkGreen").opacity(0.10))
                                        .frame(width: UIScreen.main.bounds.width / 1.25, height: 3)
                                    }
                                        Spacer()
                                            .frame(height: 15)
                                }
                            
                            }
                            .onDelete(perform: deleteSolve)
                            
                            if fourSolves.count == 0 {
                                Text("No Solves")
                                    .foregroundColor(Color("darkGreen"))
                                    .font(.custom("Roboto-BlackItalic", size: 25))
                                    .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 4.5)
                            }
                        }
                    .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 4.3)
                            
                            Button {
                                withAnimation {
                                    if firstClick {
                                        trashEnabled.isDeleting = true
                                        firstClick.toggle()
                                    } else {
                                        trashEnabled.isDeleting = false
                                        firstClick.toggle()
                                    }
                                }
                                
                                if fourSolves.count == 0 {
                                    trashEnabled.isDeleting = false
                                    firstClick = true
                                }
                            } label : {
                                if fourSolves.count == 0 {
                                    Image(systemName: "trash.circle")
                                        .resizable()
                                        .frame(width: 32.5, height: 32.5)
                                        .foregroundColor(Color("darkGreen"))
                                        .onAppear {
                                            firstClick = true
                                        }
                                } else if !trashEnabled.isDeleting {
                                    Image(systemName: "trash.circle")
                                        .resizable()
                                        .frame(width: 32.5, height: 32.5)
                                        .foregroundColor(Color("darkGreen"))
                                        .onAppear {
                                            firstClick = true
                                        }
                                } else if trashEnabled.isDeleting {
                                    Image(systemName: "trash.slash.circle")
                                        .resizable()
                                        .frame(width: 32.5, height: 32.5)
                                        .foregroundColor(Color("darkGreen"))
                                        .onAppear {
                                            firstClick = false
                                        }
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.10)
                    }
                    
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.25, alignment: .top)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .onAppear {
            trashEnabled.isDeleting = false
        }
    }
    
    func deleteSolve(at offsets: IndexSet) {
        withAnimation {
            offsets.map { fourSolves[$0] }
                .forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    func lowestTime() -> Double {
        var lowest = fourSolves.first?.timeDouble
        for solve in fourSolves {
            if solve.timeDouble < lowest! {
                lowest = solve.timeDouble
            }
        }
        
        return lowest ?? 0
    }
}

struct fourStats_Previews: PreviewProvider {
    static var previews: some View {
        fourStats()
    }
}



