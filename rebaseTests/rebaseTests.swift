//
//  rebaseTests.swift
//  rebaseTests
//
//  Created by Emma Walker on 04/02/2026.
//

import Testing
@testable import rebase

struct rebaseTests {

    @Test func testAddition() async throws {
        let calculator = Calculator()
        let result = calculator.add(2, 3)
        #expect(result == 5)
    }
    
    @Test func testSubtraction() async throws {
        let calculator = Calculator()
        let result = calculator.subtract(5, 3)
        #expect(result == 2)
    }
    
    @Test func testMultiplication() async throws {
        let calculator = Calculator()
        let result = calculator.multiply(4, by: 3)
        #expect(result == 12)
    }
    
    @Test func testDivision() async throws {
        let calculator = Calculator()
        let result = try calculator.divide(10, by: 2)
        #expect(result == 5)
    }
    
    @Test func testDivisionByZero() async throws {
        let calculator = Calculator()
        #expect(throws: CalculatorError.divisionByZero) {
            try calculator.divide(10, by: 0)
        }
    }
}
