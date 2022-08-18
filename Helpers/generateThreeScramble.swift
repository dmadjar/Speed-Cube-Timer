//
//  threeScramble.swift
//  CubeTimerV2
//
//  Created by Daniel Madjar on 6/10/22.
//

import Foundation

func generateThreeScramble(size: Int) -> String {
    var options : [String] = ["R", "L", "U", "D", "F", "B"]
    var scramble = ""
    var tempLetter = ""
    var randomLetter = Int.random(in: 0...5)
    var doubleOrPrime = Int.random(in: 0...1)
    let usedSize : Int = size - 1
    
    scramble += options[randomLetter] // scramble = "R"
    tempLetter = options[randomLetter] // tempLetter = "R"
    options.remove(at: randomLetter) // options = ["L", "U", "D", "F", "B"]
    
    if doubleOrPrime == 1 {
        scramble += "2"             // scramble = "R2"
    } else {
        doubleOrPrime = Int.random(in: 0...1)
        
        if doubleOrPrime == 1 {
            scramble += "'"
        }
    }
    
    scramble += " "                 // scramble = "R2 "
    
    for _ in 1...usedSize {
        randomLetter = Int.random(in: 0...4)
        scramble += options[randomLetter]
        options.append(tempLetter)
        tempLetter = options[randomLetter]
        options.remove(at: randomLetter)
        
        if doubleOrPrime == 1 {
            scramble += "2"
        } else {
            doubleOrPrime = Int.random(in: 0...1)
            
            if doubleOrPrime == 1 {
                scramble += "'"          
            }
        }
        
        scramble += " "
        doubleOrPrime = Int.random(in: 0...1)
    }
    
    return scramble 
}
