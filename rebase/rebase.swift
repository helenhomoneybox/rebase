//
//  rebase.swift
//  rebase
//
//  Created by Emma Walker on 04/02/2026.
//

import Foundation

public enum CalculatorError: Error {
    case divisionByZero
}

public struct Calculator {
    public init() {}
    
    public func add(_ a: Double, _ b: Double) -> Double {
        return a + b
    }
    
    public func subtract(_ a: Double, _ b: Double) -> Double {
        return a - b
    }
    
    public func multiply(_ a: Double, by b: Double) -> Double {
        return a * b
    }
    
    public func divide(_ a: Double, by b: Double) throws -> Double {
        guard b != 0 else {
            throw CalculatorError.divisionByZero
        }
        return a / b
    }
}

