import SnapshotTesting
import SwiftUI
@testable import Web3Modal
import XCTest

final class W3MTagSnapshotTests: XCTestCase {
    
    func test_snapshots() throws {
        let view = W3MTagPreviewView()
        assertSnapshot(matching: view, as: .image(layout: .fixed(width: 100, height: 250), traits: .init(userInterfaceStyle: .dark)))
        assertSnapshot(matching: view, as: .image(layout: .fixed(width: 100, height: 250), traits: .init(userInterfaceStyle: .light)))
    }
}
