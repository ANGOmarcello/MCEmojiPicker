//
//  MCEmojiPickerArrowDirectionResolverTests.swift
//  MCEmojiPickerTests
//
//  Created by Angelo Cammalleri on 30.08.26.
//

import XCTest
@testable import MCEmojiPicker

final class MCEmojiPickerArrowDirectionResolverTests: XCTestCase {
    func testAutomaticPlacementPermitsBothVerticalDirections() {
        let rawValue = MCPickerArrowDirectionResolver.permittedRawValue(explicitDirection: nil)

        XCTAssertEqual(
            rawValue,
            MCPickerArrowDirection.up.rawValue | MCPickerArrowDirection.down.rawValue
        )
    }

    func testExplicitPlacementPermitsOnlyRequestedDirection() {
        XCTAssertEqual(
            MCPickerArrowDirectionResolver.permittedRawValue(explicitDirection: .up),
            MCPickerArrowDirection.up.rawValue
        )
        XCTAssertEqual(
            MCPickerArrowDirectionResolver.permittedRawValue(explicitDirection: .down),
            MCPickerArrowDirection.down.rawValue
        )
    }
}
