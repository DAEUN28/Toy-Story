import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(kituraWithMysqlTests.allTests),
    ]
}
#endif
