//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

// define the custom errors for error processing
enum CustomError: Error {
    case invalidInput
    case divisionByZero
}

class Calculator {
    
    // sub arrays for storing numbers and operators seperately from input args
    var inputNumbers: [Int] = []//Array(repeating: 0, count: args.count)
    var inputOperators: [String] = []//Array(repeating: "", count: args.count)
    let maxPrecedence: Int = 3 // max precedence in this design is defined as 3
    
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
    
    func divide(no1: Int, no2: Int) throws -> Int{// the divide by zero error will be detected and thrown here
        guard (no2 != 0) else {
            throw CustomError.divisionByZero
        }
        return no1 / no2
    }
    
    func modulo(no1: Int, no2: Int) -> Int{
        return no1 % no2
    }
    
    // Calculator.calculate().
    // return string,
    // throws invalidInput error.
    // now this function is implemented to convert the argument input into seperate arrays,
    // make it easier to process the calculation in my approach.
    func calculate(args: [String]) throws -> String {
        
        // This function will process the input to get ready for calculationProcess running.
        guard (args.count >= 3 && (args.count % 2) != 0) else{
            if (args.count == 1){// if the first element in the args is a valid number, return this number in string format
                return String(Int(args[0])!)
            }
            throw CustomError.invalidInput
        }
        
        // initialising inputNumbers and inputOperators array to get ready for extracing elements from input args
        inputNumbers = Array(repeating: 0, count: args.count)
        inputOperators = Array(repeating: "", count: args.count)
        
        // Extracting inputs as seperated numbers and operators, into an global editable array.
        for x in stride(from: 0, to: args.count, by: 2){
            inputNumbers[x] = Int(args[x])!
        }
        
        for x in stride(from: 1, to: args.count, by: 2){
            inputOperators[x] = args[x]
        }
        
        // return the result from calling Calculator.calculateProcess().
        return String(try calculateProcess(pointer: 0, precedence: maxPrecedence))
        
    }

    // Calculator.calculatepProcess(),
    // returns integer,
    // throws divisionByZero, invalidInput error.
    // the actual calculation process happens here.
    func calculateProcess(pointer: Int, precedence: Int) throws -> Int{
        
        guard (inputNumbers.count >= 3 && inputOperators.count >= 3) else{// a guard statement to check if the input arrays are becoming too short.
            // if it is, return the first element, which should be the calculation result, and terminate.
            return inputNumbers[0]
        }
        
        // Save an editable copy of pointer and precedence indicator
        var updatePointer: Int = pointer; // iterater pointer
        var updatePrecedence: Int = precedence
        
        // this if statement is checking if current looping has reached to the end of the array.
        if (inputNumbers[updatePointer] == inputNumbers[inputNumbers.count - 1] && updatePointer == inputNumbers.count - 1){
            // Initial loop complete, a higher precedence level calculation should be completed,
            // Returning to starting point to scan for a lower level precedence calculation.
            updatePointer = 0
            updatePrecedence = updatePrecedence - 1
        }
        else{// this loop has not yet reached to the end, continue looping.
            let op = inputOperators[updatePointer + 1]
            switch updatePrecedence{// determine the calculation process based on the precedence level
            case 3:// precedence level 3 would be multiply, divide, and modulo. x, /, %
                switch op{
                case "x":
                    inputNumbers[updatePointer] = Int(multiply(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))// update this spot with calculated results
                    removeInputItems(pointer: updatePointer)// this function is for removing elements in the input array, defined in the same class
                    // other blocks follows similar logic, update the current spot with calculated results with next number, then remove the calculated operator and number from the input array
                case "/":
                    do {// This block might throw divisionbyZero error, so a do-try-catch is warpped around this part
                        try inputNumbers[updatePointer] = Int(divide(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    } catch CustomError.divisionByZero {
                        throw CustomError.divisionByZero // throw the error for higher level to catch
                    } catch {
                        print("Unexpected error: \(error)")
                    }
                    removeInputItems(pointer: updatePointer)
                case "%":
                    inputNumbers[updatePointer] = Int(modulo(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    removeInputItems(pointer: updatePointer)
                default:
                    //print("This is + or -, skipping this step")
                    updatePointer = updatePointer + 2
                }
            case 2:// precedence level 2 would be add and subtraction. +, -
                switch op{
                case "+":
                    inputNumbers[updatePointer] = Int(add(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    removeInputItems(pointer: updatePointer)
                case "-":
                    inputNumbers[updatePointer] = Int(minus(no1: inputNumbers[updatePointer], no2: inputNumbers[updatePointer + 2]))
                    removeInputItems(pointer: updatePointer)
                default:
                    //print("This is *, % or /, skipping this step")
                    updatePointer = updatePointer + 2
                }
            default:
                throw CustomError.invalidInput // there is a wrong operator detected in the input, throw an error for that
            }// end of switch precedence loop
            
        }// end of else loop
        
        // at this moment, current loop has reached to the end,
        // calling the function again with pointer moved back to start and a lower level precedence
        let _ = try calculateProcess(pointer: updatePointer, precedence: updatePrecedence)
        
        // a return statement here in case if the program reaches to here.
        // it should return the first element in the input array, which should be the final result of calculation at the end of process.
        return inputNumbers[0]
        
    } // end of calculateProcess(pointer, precedence)
    
    // Little helper function for removing elemenets in input arrays
    func removeInputItems(pointer: Int){// remove the next two elements from the pointer spot
        inputNumbers.remove(at: pointer + 2)
        inputNumbers.remove(at: pointer + 1)
        inputOperators.remove(at: pointer + 2)
        inputOperators.remove(at: pointer + 1)
    }
    
}
