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

    func testAssistantAPIResponseDecoding() throws {
        let json = """
        {
          "assistant": "Mac",
          "userId": "local-user",
          "allowed": true,
          "response": "Understood.",
          "safety": {
            "restrictedTopics": false,
            "dataScope": "Account + privacy settings"
          }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(AssistantAPIResponse.self, from: json)
        XCTAssertEqual(decoded.assistant, "Mac")
        XCTAssertEqual(decoded.userId, "local-user")
        XCTAssertTrue(decoded.allowed)
        XCTAssertEqual(decoded.safety.dataScope, "Account + privacy settings")
    }
}
