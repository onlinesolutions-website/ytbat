import XCTest
@testable import MacAssistantApp

final class MacAssistantAppTests: XCTestCase {
    func testPolicyAllowsAssistantTopic() {
        XCTAssertTrue(MacPolicy.shared.isAllowed(topic: "create reminder"))
    }

    func testPolicyRejectsUnrelatedTopic() {
        XCTAssertFalse(MacPolicy.shared.isAllowed(topic: "sports scores"))
    }

    func testDefaultFeaturesIncludeWebsiteBuilder() {
        XCTAssertTrue(AssistantFeature.defaults.map(\.title).contains("Website Builder"))
    }
}
