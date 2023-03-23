//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case invalidInput
    case divisionByZero
}

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
    
    func divide(no1: Int, no2: Int) throws -> Int{
        guard (no2 != 0) else {
            //rint("error, division by zero")
            //return 0
            throw CustomError.divisionByZero
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
    
    func calculate(args: [String]) throws -> String {
        // Todo: Calculate Result from the arguments. Replace dummyResult with your actual result;
        //let dummyResult = add(no1: 1, no2: 2);
        
        // This function will process the input to get ready for calculationProcess running.
        
        guard (args.count >= 3) else{
            //return("error, input is not long enough")
//            do{
//                return String(Int(args[0])!)// Parse the integer of single input back to the tester
//            } catch CustomError.invalidInput {
//
//            }
            if (args.count == 1){
                return String(Int(args[0])!)// Parse the integer of single input back to the tester
            }
            //return String(Int(args[0])!)// Parse the integer of single input back to the tester
            // this should throw an error to be catched by the program
            throw CustomError.invalidInput
        }
        
        // pulling numbers out from input args
        //        var inputNumbers: [Int] = Array(repeating: 0, count: args.count)
        //        var inputOperators: [String] = Array(repeating: "", count: args.count)
        inputNumbers = Array(repeating: 0, count: args.count)
        inputOperators = Array(repeating: "", count: args.count)
        
        // Extracting inputs as seperated numbers and operators, into an global editable array.
        for x in stride(from: 0, to: args.count, by: 2){
            inputNumbers[x] = Int(args[x])!
        }
        //print(inputNumbers)
        
        for x in stride(from: 1, to: args.count, by: 2){
            inputOperators[x] = args[x]
        }
        //print(inputOperators)
        
        // Pass the pointer and precedence level (default at 3) into calculateProcess function
//        do {
//            return String(try calculateProcess(pointer: 0, precedence: 3))
//        } catch CustomError.invalidInput {
//            print("Error in conversion block, invalid input")
//        } catch CustomError.divisionByZero {
//            print("Error in conversion block, division by zero")
//        }
        return String(try calculateProcess(pointer: 0, precedence: 3))
        
    }

    func calculateProcess(pointer: Int, precedence: Int) throws -> Int{
        //var inputs = args
        
        guard (inputNumbers.count >= 3 && inputOperators.count >= 3) else{
            return inputNumbers[0]
        }
        
        // Save an editable copy of pointer and precedence indicator
        var updatePointer: Int = pointer; // iterater pointer
        var updatePrecedence: Int = precedence
        //var precedence: Int = 3; // unused. precedence level indicater.
        //
        //var result = Int(args[0])!// unwarpping the args[0]?
        //var result = Int(inputs[0])!
        
        if (inputNumbers[updatePointer] == inputNumbers[inputNumbers.count - 1] && updatePointer == inputNumbers.count - 1){
            // Initial loop complete, a higher precedence level calculation should be completed,
            // Returning to starting point to scan for a lower level precedence calculation.
            updatePointer = 0
            updatePrecedence = updatePrecedence - 1
        }
        else{
            let op = inputOperators[updatePointer + 1]
            switch updatePrecedence{// determine the calculation process based on the precedence level
            case 3:// precedence level 3 would be multiply, divide, and modulo. x, /, %
                switch op{
                case "x":
                    inputNumbers[updatePointer] = Int(multiply(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    removeInputItems(pointer: updatePointer)
                    //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
                case "/":
                    do {// This block might throw divisionbyZero error, so a do-try-catch is warpped around this part
                        try inputNumbers[updatePointer] = Int(divide(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    } catch CustomError.divisionByZero {
                        //print("Error, division by zero")
                        throw CustomError.divisionByZero
                    } catch {
                        print("Unexpected error: \(error)")
                    }
                    removeInputItems(pointer: updatePointer)
                    //inputNumbers[updatePointer] = Int(divide(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
                case "%":
                    inputNumbers[updatePointer] = Int(modulo(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    removeInputItems(pointer: updatePointer)
                    //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
                default:
                    //print("This is + or -, skipping this step")
                    updatePointer = updatePointer + 2
                }
            case 2:// precedence level 2 would be add and subtraction. +, -
                switch op{
                case "+":
                    inputNumbers[updatePointer] = Int(add(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    removeInputItems(pointer: updatePointer)
                    //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
                case "-":
                    inputNumbers[updatePointer] = Int(minus(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    removeInputItems(pointer: updatePointer)
                    //print("updating spot \(updatePointer) with number \(inputNumbers[updatePointer])")
                default:
                    //print("This is *, % or /, skipping this step")
                    updatePointer = updatePointer + 2
                }
            default:
                //print("Finalising calculation")// most likely this line would not be printed. this is part of switch precedence loop.
                throw CustomError.invalidInput
            }// end of switch precedence loop/ 
            
            //print(inputNumbers)
            //print(inputOperators)
            //print("After checking, now pointer is reading \(inputNumbers[updatePointer]) at spot \(updatePointer)")
        }// end of else loop
        
        try calculateProcess(pointer: updatePointer, precedence: updatePrecedence)
        return inputNumbers[0]
        
    } // end of calculateProcess(pointer, precedence)
    
    // Little helper function for removing elemenets in input arrays
    func removeInputItems(pointer: Int){
        inputNumbers.remove(at: pointer + 2)
        inputNumbers.remove(at: pointer + 1)
        inputOperators.remove(at: pointer + 2)
        inputOperators.remove(at: pointer + 1)
    }
    
}
