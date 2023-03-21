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
//    var pointer: Int = 0; /// iterater pointer
//    var precedence: Int = 0; /// unused. precedence level indicater.
    
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
    
    /// Reusable calculation functions
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
        if (no2 == 0){
            print("error, division by zero")
        }
        return no1 / no2
    }
    
    func modulo(no1: Int, no2: Int) -> Int{
        return no1 % no2
    }
    
    func calculate(args: [String]) -> String {
        // Todo: Calculate Result from the arguments. Replace dummyResult with your actual result;
        //let dummyResult = add(no1: 1, no2: 2);

        guard (args.count >= 3) else{
            return("error, input is not long enough")
            /// this should throw an error to be catched by the program
        }
        
        var inputs = args
        var pointer: Int = 0; /// iterater pointer
        var precedence: Int = 3; /// unused. precedence level indicater.
        ///
        var result = Int(args[0])!// unwarpping the args[0]?
        
        for precedence in stride(from: 3, to: 1, by: -1){
            print("At precedence level \(precedence) the result is \(result)")
            for index in stride(from: 2, to: args.count, by:2){
                let op = args[index - 1]// getting the operator from odd spots
                let number = Int(args[index])!// unwarpping stuff
                
                switch precedence{ // determine the calculation level based on this precedence indicator.
                case 3:
                    switch op{
                    case "*":
                        result = multiply(no1: result, no2: number)
                        inputs.remove(at: index-1)
                        inputs.remove(at: index-1)
                    case "/":
                        result = Int(divide(no1: result, no2: number))
                        inputs.remove(at: index-1)
                        inputs.remove(at: index-1)
                        //print(inputs)
                    case "%":
                        result = modulo(no1: result, no2: number)
                        inputs.remove(at: index-1)
                        inputs.remove(at: index-1)
                    default:
                        print("No precedence 3 calculation detected. ")
                        //fatalError()
                    }
                case 2:
                    switch op{
                    case "+":
                        result = add(no1: result, no2: number)
                        inputs.remove(at: index-1)
                        inputs.remove(at: index-1)
                    case "-":
                        result = minus(no1: result, no2: number)
                        inputs.remove(at: index-1)
                        inputs.remove(at: index-1)
                    default:
                        print("No precedence 2 calculation detected. ")
                        //fatalError()
                    }
                default:
                    print("calculation process complete")
                }// end of switch precedence loop
                //precedence = precedence - 1 // decrease the precedence to get into next step.
            }// end of index loop
        }// end of for precedence loop
        
        let resultString = String(result);
        return(resultString)
    }
}
