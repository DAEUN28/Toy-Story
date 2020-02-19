import XCTest

import kituraWithMysqlTests

var tests = [XCTestCaseEntry]()
tests += kituraWithMysqlTests.allTests()
XCTMain(tests)
