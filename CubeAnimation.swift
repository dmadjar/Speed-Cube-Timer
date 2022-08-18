//
//  CubeAnimation.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 7/3/22.
//

import SwiftUI

struct CubeAnimation: View {

    
    var body: some View {
        VStack(spacing: 2.5) {
                
                HStack(spacing: 2.5) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("orangeColor"))
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("greenColor"))
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("yellowColor"))
                }
                .frame(width: 70, height: 22.5)

                
                HStack(spacing: 2.5) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("yellowColor"))
                        
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("textColor"))
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("blueColor"))
                }
                .frame(width: 70, height: 22.5)

                
                HStack(spacing: 2.5) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("blueColor"))
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("orangeColor"))
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("greenColor"))
                }
                .frame(width: 70, height: 22.5)
                    
            }
            .frame(width: 70, height: 75)
            
        
    }
}

struct CubeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CubeAnimation()
    }
}
