//
//  Stock+Catalog.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

extension Stock {
    static let catalog: [Stock] = [
        Stock(
            symbol: "AAPL",
            name: "Apple Inc.",
            summary: String(localized: "summary.AAPL", defaultValue: "Designs and sells the iPhone, Mac, iPad and Apple Watch, plus services such as the App Store, iCloud and Apple Music."),
            price: 228.50
        ),
        Stock(
            symbol: "MSFT",
            name: "Microsoft Corporation",
            summary: String(localized: "summary.MSFT", defaultValue: "Makes Windows and Office and runs Azure, one of the largest cloud computing platforms in the world."),
            price: 418.20
        ),
        Stock(
            symbol: "NVDA",
            name: "NVIDIA Corporation",
            summary: String(localized: "summary.NVDA", defaultValue: "Designs GPUs and accelerated computing platforms used for gaming, data centers and AI training."),
            price: 132.80
        ),
        Stock(
            symbol: "GOOG",
            name: "Alphabet Inc.",
            summary: String(localized: "summary.GOOG", defaultValue: "Parent company of Google, operating Search, YouTube, Android and Google Cloud."),
            price: 165.40
        ),
        Stock(
            symbol: "AMZN",
            name: "Amazon.com, Inc.",
            summary: String(localized: "summary.AMZN", defaultValue: "Runs a global e-commerce marketplace and Amazon Web Services, the leading cloud infrastructure provider."),
            price: 186.90
        ),
        Stock(
            symbol: "META",
            name: "Meta Platforms, Inc.",
            summary: String(localized: "summary.META", defaultValue: "Owns Facebook, Instagram, WhatsApp and Messenger, and invests heavily in AI and mixed reality."),
            price: 572.30
        ),
        Stock(
            symbol: "TSLA",
            name: "Tesla, Inc.",
            summary: String(localized: "summary.TSLA", defaultValue: "Manufactures electric vehicles, battery storage systems and solar products."),
            price: 248.60
        ),
        Stock(
            symbol: "AVGO",
            name: "Broadcom Inc.",
            summary: String(localized: "summary.AVGO", defaultValue: "Supplies semiconductors and infrastructure software for networking, storage and wireless."),
            price: 171.20
        ),
        Stock(
            symbol: "ORCL",
            name: "Oracle Corporation",
            summary: String(localized: "summary.ORCL", defaultValue: "Provides database software, enterprise applications and cloud infrastructure."),
            price: 168.70
        ),
        Stock(
            symbol: "ADBE",
            name: "Adobe Inc.",
            summary: String(localized: "summary.ADBE", defaultValue: "Makes creative and document software including Photoshop, Illustrator and Acrobat."),
            price: 512.40
        ),
        Stock(
            symbol: "CRM",
            name: "Salesforce, Inc.",
            summary: String(localized: "summary.CRM", defaultValue: "Provides cloud-based customer relationship management software for sales, service and marketing."),
            price: 287.10
        ),
        Stock(
            symbol: "AMD",
            name: "Advanced Micro Devices, Inc.",
            summary: String(localized: "summary.AMD", defaultValue: "Designs CPUs and GPUs for PCs, gaming consoles and data centers."),
            price: 158.30
        ),
        Stock(
            symbol: "INTC",
            name: "Intel Corporation",
            summary: String(localized: "summary.INTC", defaultValue: "Designs and manufactures processors and other semiconductor products."),
            price: 22.90
        ),
        Stock(
            symbol: "NFLX",
            name: "Netflix, Inc.",
            summary: String(localized: "summary.NFLX", defaultValue: "Operates a subscription streaming service for films, series and games."),
            price: 702.50
        ),
        Stock(
            symbol: "QCOM",
            name: "QUALCOMM Incorporated",
            summary: String(localized: "summary.QCOM", defaultValue: "Develops mobile chipsets and wireless technology, licensing patents used in most smartphones."),
            price: 169.80
        ),
        Stock(
            symbol: "CSCO",
            name: "Cisco Systems, Inc.",
            summary: String(localized: "summary.CSCO", defaultValue: "Builds networking hardware, security and collaboration software."),
            price: 53.40
        ),
        Stock(
            symbol: "IBM",
            name: "International Business Machines",
            summary: String(localized: "summary.IBM", defaultValue: "Provides hybrid cloud, consulting and enterprise AI services."),
            price: 221.60
        ),
        Stock(
            symbol: "UBER",
            name: "Uber Technologies, Inc.",
            summary: String(localized: "summary.UBER", defaultValue: "Runs ride-hailing, food delivery and freight platforms worldwide."),
            price: 78.20
        ),
        Stock(
            symbol: "SHOP",
            name: "Shopify Inc.",
            summary: String(localized: "summary.SHOP", defaultValue: "Provides a commerce platform for merchants to run online and in-person stores."),
            price: 80.10
        ),
        Stock(
            symbol: "PYPL",
            name: "PayPal Holdings, Inc.",
            summary: String(localized: "summary.PYPL", defaultValue: "Operates digital payment platforms including PayPal and Venmo."),
            price: 79.50
        ),
        Stock(
            symbol: "JPM",
            name: "JPMorgan Chase & Co.",
            summary: String(localized: "summary.JPM", defaultValue: "Largest US bank, offering consumer banking, investment banking and asset management."),
            price: 211.30
        ),
        Stock(
            symbol: "V",
            name: "Visa Inc.",
            summary: String(localized: "summary.V", defaultValue: "Runs a global card payments network connecting consumers, merchants and banks."),
            price: 281.70
        ),
        Stock(
            symbol: "MA",
            name: "Mastercard Incorporated",
            summary: String(localized: "summary.MA", defaultValue: "Operates a worldwide payments network and related data services."),
            price: 497.90
        ),
        Stock(
            symbol: "DIS",
            name: "The Walt Disney Company",
            summary: String(localized: "summary.DIS", defaultValue: "Entertainment company with film studios, theme parks, streaming and media networks."),
            price: 94.60
        ),
        Stock(
            symbol: "KO",
            name: "The Coca-Cola Company",
            summary: String(localized: "summary.KO", defaultValue: "Makes and markets non-alcoholic beverages sold in more than 200 countries."),
            price: 69.80
        ),
    ]
}
