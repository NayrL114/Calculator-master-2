//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {
    
    /// For multi-step calculation, it's helpful to persist existing result
    var currentResult = 0;
    
    /// Perform Addition
    ///
    /// - Author: Jacktator
    /// - Parameters:
    ///   - no1: First number
    ///   - no2: Second number
    /// - Returns: The addition result
    ///
    /// - Warning: The result may yield Int overflow.
    /// - SeeAlso: https://developer.apple.com/documentation/swift/int/2884663-addingreportingoverflow
    
    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2;
    }
    
    func minus(no1: Int, no2: Int) -> Int{
        return no1 - no2
    }
    
    func multiply(no1: Int, no2: Int) -> Int{
        return no1 * no2
    }
    
    func divide(no1: Int, no2: Int) -> Int{
        return no1 / no2
    }
    
    func modulo(no1: Int, no2: Int) -> Int{
        return no1 % no2
    }
    
    func calculate(args: [String]) -> String {
        // Todo: Calculate Result from the arguments. Replace dummyResult with your actual result;
        //let dummyResult = add(no1: 1, no2: 2);
        var result = Int(args[0])!// unwarpping the args[0]?
        
        for index in stride(from: 2, to: args.count, by:2){
            let op = args[index - 1]// getting the operator from odd spots
            let number = Int(args[index])!// unwarpping stuff
            
            switch op{
            case "+":
                result = add(no1: result, no2: number)
            case "-":
                result = minus(no1: result, no2: number)
            case "*":
                result = multiply(no1: result, no2: number)
            case "/":
                result = Int(divide(no1: result, no2: number))
            case "%":
                result = modulo(no1: result, no2: number)
            default:
                print("String error")
                fatalError()
            }
        }
        
        let resultString = String(result);
        return(resultString)
    }
}
