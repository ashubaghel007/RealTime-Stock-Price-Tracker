//
//  LocalizationTests.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import XCTest
@testable import PriceTracker

/// Fails CI when a string is added to the UI without its Arabic translation.
final class LocalizationTests: XCTestCase {

    private let uiKeys = [
        "Stocks", "Start", "Stop", "Sort by", "Price", "Price Change",
        "Connected", "Connecting…", "Disconnected",
        "About", "Symbol not found", "Connection lost. Tap Start to reconnect.",
    ]

    private func bundle(for language: String) throws -> Bundle {
        let path = try XCTUnwrap(
            Bundle.main.path(forResource: language, ofType: "lproj"),
            "\(language).lproj is missing from the app bundle"
        )
        return try XCTUnwrap(Bundle(path: path))
    }

    func test_arabic_translatesEveryUIString() throws {
        let arabic = try bundle(for: "ar")

        for key in uiKeys {
            let value = arabic.localizedString(forKey: key, value: nil, table: nil)
            XCTAssertNotEqual(value, key, "Missing Arabic translation for '\(key)'")
        }
    }

    func test_everySymbol_hasADescriptionInEnglishAndArabic() throws {
        for language in ["en", "ar"] {
            let bundle = try bundle(for: language)

            for stock in Stock.catalog {
                let key = "summary.\(stock.symbol)"
                let value = bundle.localizedString(forKey: key, value: nil, table: nil)
                XCTAssertNotEqual(value, key, "Missing \(language) description for \(stock.symbol)")
            }
        }
    }
}
