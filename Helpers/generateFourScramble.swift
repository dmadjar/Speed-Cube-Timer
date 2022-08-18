//
//  generateFourScramble.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 6/12/22.
//

import Foundation

func generateFourScramble(size: Int) -> String {
    var options : [String] = ["R", "L", "U", "D", "F", "B", "r", "l", "u", "d", "f", "b"]
    var scramble = ""
    var tempLetter = ""
    var randomLetter = Int.random(in: 0...11)
    var doubleOrPrime = Int.random(in: 0...1)
    let usedSize = size - 1
    
    scramble += options[randomLetter]
    tempLetter = options[randomLetter]
    options.remove(at: randomLetter)
    
    if doubleOrPrime == 1 {
        scramble += "2"             // scramble = "R2"
    } else {
        doubleOrPrime = Int.random(in: 0...1)
        
        if doubleOrPrime == 1 {
            scramble += "'"
        }
    }
    
    scramble += " "
    
    for _ in 1...usedSize {
        randomLetter = Int.random(in: 0...10)
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
