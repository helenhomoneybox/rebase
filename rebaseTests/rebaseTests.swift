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

}
