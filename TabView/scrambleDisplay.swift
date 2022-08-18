//
//  scrambleDisplay.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/11/22.
//

import SwiftUI
import MessageUI

struct scrambleDisplay: View {
    @Environment(\.presentationMode) var presentationMode
    var scramble : String
    var time: String
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var color : Color
    
    @State private var isShowingMessages = false
    
    var body: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: screenHeight / 22.5)
                    
                    Text("Scramble")
                        .font(.custom("Roboto-Black", size: screenWidth * 0.05))
                        .frame(width: screenWidth / 1.2, alignment: .leading)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(color)
                            .frame(width: screenWidth / 1.2, height: screenHeight / 4.5)
                            .shadow(color: Color.black.opacity(0.4), radius: 6, x: 5, y: 5)
                    
                        Text(scramble)
                            .foregroundColor(.white)
                            .font(.custom("Roboto-Black", size: screenWidth * 0.065))
                            .multilineTextAlignment(.center)
                            .frame(width: screenWidth / 1.5)
                    }
                    
                    Spacer()
                        .frame(height: screenHeight / 35)
                    
                    Text("Time")
                        .font(.custom("Roboto-Black", size: screenWidth * 0.05))
                        .frame(width: screenWidth / 1.2, alignment: .leading)
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(color)
                                .frame(width: screenWidth / 1.75, height: screenHeight / 12)
                                .shadow(color: Color.black.opacity(0.4), radius: 6, x: 5, y: 5)
                                
                            Text(time)
                                .foregroundColor(.white)
                                .font(.custom("Roboto-Black", size: screenWidth * 0.10))
                        }
                        
                        Spacer()
                        
                        Spacer()
                        
                        Button {
                            self.isShowingMessages = true
                        } label : {
                            Image(systemName: "paperplane.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(color)
                        }
                        .accentColor(.white)
                        .sheet(isPresented: self.$isShowingMessages) {
                            MessageComposeView(recipients: [""], body: "I just got \(time). Can you beat my time? Scramble: \(scramble)") { messageSent in
                                print("MessageComposeView with message sent? \(messageSent)")
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(width: screenWidth / 1.2, height: screenHeight / 10, alignment: .leading)
                    
                    Spacer()
            }
            .frame(height: screenHeight / 1.5)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label : {
                HStack {
                    Image(systemName: "arrow.left")
                        .renderingMode(.template)
                        .foregroundColor(color)
                    
                    Text("Go Back")
                        .foregroundColor(color)
                }
                .padding(.leading, 10)
            }
        )
                
    }
}

struct MessageComposeView: UIViewControllerRepresentable {
    typealias Completion = (_ messageSent: Bool) -> Void

    static var canSendText: Bool { MFMessageComposeViewController.canSendText() }
        
    let recipients: [String]?
    let body: String?
    let completion: Completion?
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard Self.canSendText else {
            let errorView = MessagesUnavailableView()
            return UIHostingController(rootView: errorView)
        }
        
        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = context.coordinator
        controller.recipients = recipients
        controller.body = body
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completion: self.completion)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        private let completion: Completion?

        public init(completion: Completion?) {
            self.completion = completion
        }
        
        public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
            completion?(result == .sent)
        }
    }
}

struct MessagesUnavailableView: View {
    var body: some View {
        ZStack {
            
            Color("backgroundColor").ignoresSafeArea()
            
            VStack(spacing: 10) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 64))
                    .foregroundColor(.red)
                Text("Sharing Is Unavailable")
                    .font(.custom("Roboto-Black", size: 24))
            }
        }
    }
}

struct scrambleDisplay_Previews: PreviewProvider {
    static let scramble = generateThreeScramble(size: 25)
    static let time = "0:05:32"
    
    static var previews: some View {
        Group {
            scrambleDisplay(scramble: scramble, time: time, color: Color("blueColor"))
                .preferredColorScheme(.light)
        }
    }
}
