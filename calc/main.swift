//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

// Retrieve User Input
//let no1 = args[0]; // Sample Code Only! Update Required!
//let operator = args[1]; // Sample Code Only! Update Required!
//let no2 = args[1]; // Sample Code Only! Update Required!

// Initialize a Calculator object
let calculator = Calculator();
var result: String = ""

// Calculate the result
//let result = calculator.add(no1: 1, no2: 1);
do{
    result = try calculator.calculate(args: args)
} catch CustomError.divisionByZero {
    print("Error in main, division by zero")
} catch {
    print("Unexpected error: \(error)")
}
//let result = calculator.calculate(args: args)

print(result)
