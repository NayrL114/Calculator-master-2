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
    var inputNumbers: [Int] = []//Array(repeating: 0, count: args.count)
    var inputOperators: [String] = []//Array(repeating: "", count: args.count)
    
    
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
    
    // Reusable calculation functions
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
        guard (no2 != 0) else {
            print("error, division by zero")
            return 0
        }
        return no1 / no2
    }
    
    func modulo(no1: Int, no2: Int) -> Int{
        return no1 % no2
    }
    
    ///
    /// TO DO ! :
    ///  FIND WAYS TO FIX THE PRECEDENCE LOOP.
    ///  FIND WAYS TO INCORPORATE THE COPIED INPUT ARRAY INTO THE LOOP
    ///  MAYBE DO A NEW FOR LOOP TO CONVERT EVERY NUMBER IN INPUTS ARRAY INTO NUMBERS
    
    func calculate(args: [String]) -> String {
        // Todo: Calculate Result from the arguments. Replace dummyResult with your actual result;
        //let dummyResult = add(no1: 1, no2: 2);
        
        guard (args.count >= 3) else{
            return("error, input is not long enough")
            // this should throw an error to be catched by the program
        }
        
        // pulling numbers out from input args
        //        var inputNumbers: [Int] = Array(repeating: 0, count: args.count)
        //        var inputOperators: [String] = Array(repeating: "", count: args.count)
        inputNumbers = Array(repeating: 0, count: args.count)
        inputOperators = Array(repeating: "", count: args.count)
        
        for x in stride(from: 0, to: args.count, by: 2){
            inputNumbers[x] = Int(args[x])!
        }
        //print(inputNumbers)
        
        for x in stride(from: 1, to: args.count, by: 2){
            inputOperators[x] = args[x]
        }
        //print(inputOperators)
        
        return String(calculateProcess(pointer: 0))
        
    }

    func calculateProcess(pointer: Int) -> Int{
        //var inputs = args
        
        guard (inputNumbers.count >= 3 && inputOperators.count >= 3) else{
            return inputNumbers[0]
        }
        
        var updatePointer: Int = pointer; // iterater pointer
        //var precedence: Int = 3; // unused. precedence level indicater.
        //
        //var result = Int(args[0])!// unwarpping the args[0]?
        //var result = Int(inputs[0])!
        
        if (inputNumbers[updatePointer] == inputNumbers[inputNumbers.count - 1]){
            updatePointer = updatePointer - 2
            //print("Right now pointer is reverse reading \(inputNumbers[updatePointer]) at spot \(updatePointer)")
            let op = inputOperators[updatePointer + 1]
            switch op{
            case "+":
                inputNumbers[updatePointer] = Int(add(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
            case "-":
                inputNumbers[updatePointer] = Int(minus(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
            default:
                print("This is %/*, skipping this step")
            }
            //print("After reverse checking, now pointer is reading \(inputNumbers[updatePointer]) at spot \(updatePointer)")
            inputNumbers.remove(at: updatePointer + 2)
            inputNumbers.remove(at: updatePointer + 1)
            inputOperators.remove(at: updatePointer + 2)
            inputOperators.remove(at: updatePointer + 1)
            //print(inputNumbers)
            //print(inputOperators)
        }
        else{
            let op = inputOperators[updatePointer + 1]
            switch op{
            case "*":
                inputNumbers[updatePointer] = Int(multiply(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
                inputNumbers.remove(at: updatePointer + 2)
                inputNumbers.remove(at: updatePointer + 1)
                inputOperators.remove(at: updatePointer + 2)
                inputOperators.remove(at: updatePointer + 1)
            case "/":
                inputNumbers[updatePointer] = Int(divide(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
                inputNumbers.remove(at: updatePointer + 2)
                inputNumbers.remove(at: updatePointer + 1)
                inputOperators.remove(at: updatePointer + 2)
                inputOperators.remove(at: updatePointer + 1)
            case "%":
                inputNumbers[updatePointer] = Int(modulo(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
                inputNumbers.remove(at: updatePointer + 2)
                inputNumbers.remove(at: updatePointer + 1)
                inputOperators.remove(at: updatePointer + 2)
                inputOperators.remove(at: updatePointer + 1)
            default:
                //print("This is + or -, skipping this step")
                updatePointer = updatePointer + 2
            }
            //print(inputNumbers)
            //print(inputOperators)
            //print("After checking, now pointer is reading \(inputNumbers[updatePointer]) at spot \(updatePointer)")
        }
        
        
//
//        for precedence in stride(from: 3, to: 1, by: -1){
//            print("At precedence level \(precedence) the result is \(result)")
//            for index in stride(from: 2, to: args.count, by:2){
//                let op = args[index - 1]// getting the operator from odd spots
//                let number = Int(args[index])!// unwarpping stuff
//
//                switch precedence{ // determine the calculation level based on this precedence indicator.
//                case 3:
//                    switch op{
//                    case "*":
//                        result = Int(multiply(no1: result, no2: number))
////                        inputs.remove(at: index-1)
////                        inputs.remove(at: index-1)
//                    case "/":
//                        result = Int(divide(no1: result, no2: number))
////                        inputs.remove(at: index-1)
////                        inputs.remove(at: index-1)
//                        //print(inputs)
//                    case "%":
//                        result = modulo(no1: result, no2: number)
////                        inputs.remove(at: index-1)
////                        inputs.remove(at: index-1)
//                    default:
//                        print("No precedence 3 calculation detected. ")
//                        //fatalError() // might need to throw a input string error here
//                    }
//                case 2:
//                    switch op{
//                    case "+":
//                        result = add(no1: result, no2: number)
////                        inputs.remove(at: index-1)
////                        inputs.remove(at: index-1)
//                    case "-":
//                        result = minus(no1: result, no2: number)
////                        inputs.remove(at: index-1)
////                        inputs.remove(at: index-1)
//                    default:
//                        print("No precedence 2 calculation detected. ")
//                        //fatalError()
//                    }
//                default:
//                    print("calculation process complete")
//                }// end of switch precedence loop
//                //precedence = precedence - 1 // decrease the precedence to get into next step.
//            }// end of index loop
//        }// end of for precedence loop
//
        
        //let resultString = String(result);
        //return(resultString)
        
        calculateProcess(pointer: updatePointer)
        return inputNumbers[0]
        
    }
}
