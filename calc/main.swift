//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

enum CustomErrorCode: Int32 {
    case INVALID_INPUT = 1
    case DIVISION_BY_ZERO
    case UNEXPECTED_ERROR = 404
}

// This code already exist in the provided scaffold code, getting inputs from argument inputs
var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

// Initialize a Calculator object
let calculator = Calculator();
var result: String = ""

// Calculate the result
do{ // As the calculator.calculate() will not throw error, a do-try-catch statement is warpped around.
    print(try calculator.calculate(args: args))
} catch CustomError.divisionByZero {
    print("Error in main, division by zero")
    exit(CustomErrorCode.DIVISION_BY_ZERO.rawValue)
} catch CustomError.invalidInput {
    print("Error in main, invalid input")
    exit(CustomErrorCode.INVALID_INPUT.rawValue)
} catch {
    print("Unexpected error: \(error)")
    exit(CustomErrorCode.UNEXPECTED_ERROR.rawValue)
}
