//
//  Copyright 2026 Readium Foundation. All rights reserved.
//  Use of this source code is governed by the BSD-style license
//  available in the top-level LICENSE file of the project.
//

@testable import ReadiumNavigator
import XCTest

final class AudioBufferingStrategyTests: XCTestCase {
    func testConfiguration() {
        XCTAssertEqual(AudioNavigator.Configuration().bufferingStrategy, .immediate)
        XCTAssertEqual(
            AudioNavigator.Configuration(
                bufferingStrategy: .minimizeStalls(preferredForwardBufferDuration: 30)
            ).bufferingStrategy,
            .minimizeStalls(preferredForwardBufferDuration: 30)
        )
    }

    func testImmediate() {
        let strategy = AudioBufferingStrategy.immediate

        XCTAssertFalse(strategy.automaticallyWaitsToMinimizeStalling)
        XCTAssertEqual(strategy.preferredForwardBufferDuration, 0)
    }

    func testMinimizeStalls() {
        let strategy = AudioBufferingStrategy.minimizeStalls(preferredForwardBufferDuration: 30)

        XCTAssertTrue(strategy.automaticallyWaitsToMinimizeStalling)
        XCTAssertEqual(strategy.preferredForwardBufferDuration, 30)
    }

    func testNegativeForwardBufferDurationIsClamped() {
        let strategy = AudioBufferingStrategy.minimizeStalls(preferredForwardBufferDuration: -1)

        XCTAssertEqual(strategy.preferredForwardBufferDuration, 0)
    }
}
