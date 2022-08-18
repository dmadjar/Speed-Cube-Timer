//
//  ContentView.swift
//  CubeTimerV2
//
//  Created by Daniel Madjar on 6/9/22.
//

import SwiftUI

struct stopwatch: View {
    @EnvironmentObject var appState : AppState
    @EnvironmentObject var timerManager: TimerManager
    @EnvironmentObject var appThemeViewModel : AppThemeViewModel
    @EnvironmentObject var isTimerRunningObject : isTimerRunning
    @Environment(\.managedObjectContext) var managedObjContext
    
    @State var countDownTimer = 10
    @State var whichCube : Int = 1
    @State var cubes : [String] = ["2x2", "3x3", "4x4"]
    
    @Binding var scramble : String
    
    @State var isButtonPressed = false
    @State var stopInspection = false
    @State var stopTimer = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("backgroundColor").ignoresSafeArea()
                
                VStack(alignment: .center) {
                    Spacer()
                        .frame(width: geo.size.width, height: geo.size.height * 0.1)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("orangeColor"))
                            .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.2)
                            .shadow(color: Color.black.opacity(0.4), radius: 6, x: 5, y: 5)
                        
                        Text(scramble)
                            .foregroundColor(.white)
                            .font(.custom("Roboto-Black", size: geo.size.width * 0.065))
                            .frame(width: geo.size.width * 0.7)
                            .multilineTextAlignment(.center)
                    }
                    .hidden(!isTimerRunningObject.firstTap || isTimerRunningObject.timerRunning)
                    
                    Spacer()
                        .frame(width: geo.size.width, height: geo.size.height * 0.1)
                    
                    if appThemeViewModel.inspectTimer {
                        if isTimerRunningObject.timerRunning && countDownTimer == 4 {
                            Text("\(countDownTimer)")
                            .foregroundColor(Color("textColor"))
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.25))
                            .frame(width: geo.size.width)
                            .onReceive(timer) { _ in
                                if countDownTimer > 1 && isTimerRunningObject.timerRunning {
                                    countDownTimer -= 1
                                }
                                
                                if appThemeViewModel.inspectSound {
                                    SoundManager.instance.playSound(note: "noteC")
                                }
                            }
                        }
                        else if isTimerRunningObject.timerRunning && countDownTimer == 3 {
                            Text("\(countDownTimer)")
                            .foregroundColor(Color("orangeColor"))
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.25))
                            .frame(width: geo.size.width)
                            .onReceive(timer) { _ in
                                if countDownTimer > 1 && isTimerRunningObject.timerRunning {
                                    countDownTimer -= 1
                                }
                                
                                if appThemeViewModel.inspectSound {
                                    SoundManager.instance.playSound(note: "noteC")
                                }
                            }
                        } else if isTimerRunningObject.timerRunning && countDownTimer == 2 {
                            Text("\(countDownTimer)")
                            .foregroundColor(Color("yellowColor"))
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.25))
                            .frame(width: geo.size.width)
                            .onReceive(timer) { _ in
                                if countDownTimer > 1 && isTimerRunningObject.timerRunning {
                                    countDownTimer -= 1
                                }
                                
                                if appThemeViewModel.inspectSound {
                                    SoundManager.instance.playSound(note: "noteC")
                                }
                            }
                        } else if isTimerRunningObject.timerRunning && countDownTimer == 1 {
                            Text("\(countDownTimer)")
                            .foregroundColor(Color("greenColor"))
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.25))
                            .frame(width: geo.size.width)
                            .onReceive(timer) { _ in
                               
                                isTimerRunningObject.timerRunning = false
                                startTimer()
                                stopInspection = false
                                isTimerRunningObject.firstTap = false
                                stopTimer = true
                                
                                if appThemeViewModel.inspectSound {
                                    SoundManager.instance.playSound(note: "noteG")
                                }
                            }
                        } else if isTimerRunningObject.timerRunning {
                            Text("\(countDownTimer)")
                            .foregroundColor(Color("textColor"))
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.25))
                            .frame(width: geo.size.width)
                            .onReceive(timer) { _ in
                                if countDownTimer > 1 && isTimerRunningObject.timerRunning {
                                    countDownTimer -= 1
                                }
                            }
                        }
                        else {
                            Text("\(timerManager.elapsedSecondsFormatted)")
                                .foregroundColor(Color("textColor"))
                                .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.25))
                                .frame(width: geo.size.width)
                        }
                    } else {
                        Text("\(timerManager.elapsedSecondsFormatted)")
                            .foregroundColor(Color("textColor"))
                            .font(.custom("Roboto-BlackItalic", size: geo.size.width * 0.25))
                            .frame(width: geo.size.width)
                    }
                    
                    Spacer()
                }
                
                
                if appThemeViewModel.inspectTimer && !isButtonPressed {
                    if isTimerRunningObject.firstTap {
                        Button {
                            isTimerRunningObject.timerRunning = true
                            isTimerRunningObject.firstTap = false
                            stopInspection = true
                        } label : {
                            Text("")
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    } else if stopInspection {
                        Button {
                            stopInspection = false
                            isTimerRunningObject.timerRunning = false
                            countDownTimer = appThemeViewModel.inspectLength
                            stopTimer = true
                            startTimer()
                        } label : {
                            Text("")
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    } else if !isTimerRunningObject.timerRunning && stopTimer {
                        Button {
                            stopTimer = false
                            endTimer()
                            isTimerRunningObject.firstTap = true
                            countDownTimer = appThemeViewModel.inspectLength
                            if whichCube == 0 {
                                DataController().addTwoSolve(scramble: scramble, timeDouble: timerManager.finalDuration, timeString: timerManager.elapsedSecondsFormatted, context: managedObjContext)
                                
                                scramble = generateThreeScramble(size: appThemeViewModel.scrambleLength)
                            } else if whichCube == 1 {
                                DataController().addSolve(scramble: scramble, timeDouble: timerManager.finalDuration, timeString: timerManager.elapsedSecondsFormatted, context: managedObjContext)
                                
                                scramble = generateThreeScramble(size: appThemeViewModel.scrambleLength)
                            } else if whichCube == 2 {
                                DataController().addFourSolve(scramble: scramble, timeDouble: timerManager.finalDuration, timeString: timerManager.elapsedSecondsFormatted, context: managedObjContext)
                                
                                scramble = generateFourScramble(size: appThemeViewModel.scrambleLength)
                            }
                        } label : {
                            Text("")
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    }
                } else if !isButtonPressed {
                    if isTimerRunningObject.firstTap {
                        Button {
                            startTimer()
                            isTimerRunningObject.firstTap = false
                        } label : {
                            Text("")
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    } else {
                        Button {
                            endTimer()
                            isTimerRunningObject.firstTap = true
                            if whichCube == 0 {
                                DataController().addTwoSolve(scramble: scramble, timeDouble: timerManager.finalDuration, timeString: timerManager.elapsedSecondsFormatted, context: managedObjContext)
                                
                                scramble = generateThreeScramble(size: appThemeViewModel.scrambleLength)
                            } else if whichCube == 1 {
                                DataController().addSolve(scramble: scramble, timeDouble: timerManager.finalDuration, timeString: timerManager.elapsedSecondsFormatted, context: managedObjContext)
                                
                                scramble = generateThreeScramble(size: appThemeViewModel.scrambleLength)
                           } else if whichCube == 2 {
                               DataController().addFourSolve(scramble: scramble, timeDouble: timerManager.finalDuration, timeString: timerManager.elapsedSecondsFormatted, context: managedObjContext)
                               
                               scramble = generateFourScramble(size: appThemeViewModel.scrambleLength)
                           }
                        } label : {
                            Text("")
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                           
                        Menu {
                            Button {
                                whichCube = 0
                                isButtonPressed = false
                                scramble = generateThreeScramble(size: appThemeViewModel.scrambleLength)
                            } label : {
                                Text("2x2")
                            }
                            
                                Button {
                                   whichCube = 1
                                   isButtonPressed = false
                                   scramble = generateThreeScramble(size: appThemeViewModel.scrambleLength)
                                } label : {
                                    Text("3x3")
                                }
                            
                                    Button {
                                        whichCube = 2
                                        isButtonPressed = false
                                        scramble = generateFourScramble(size: appThemeViewModel.scrambleLength)
                                    } label : {
                                        Text("4x4")
                                    }
                        } label: {
                            Text(cubes[whichCube])
                                .font(.custom("Roboto-Black", size: 17.5))
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(Color("orangeColor"))
                                .cornerRadius(15)
                        }
                        .accentColor(.white)
                        .hidden(!isTimerRunningObject.firstTap || isTimerRunningObject.timerRunning)
                        .onTapGesture {
                            isButtonPressed = true
                        }
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.15)
                }
            }
            .onTapGesture {
                isButtonPressed = false
            }
        }
        .onAppear {
            countDownTimer = appThemeViewModel.inspectLength
        }
    }
        
    
    func startTimer() {
        timerManager.setUpTimer()
    }
    
    func endTimer() {
        timerManager.endTimer()
    }
}

struct stopwatch_Previews: PreviewProvider {
    static let timerPreview = TimerManager()
    static let appThemeViewModel = AppThemeViewModel()
    static let isTimerRunningObject = isTimerRunning()
    
    static var previews: some View {
        stopwatch(scramble: .constant(generateThreeScramble(size: 25)))
                .environmentObject(timerPreview)
                .environmentObject(isTimerRunningObject)
                .environmentObject(appThemeViewModel)
                .preferredColorScheme(.light)

    }
}

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
