//
//  Theme.swift
//  Concentration
//
//  Created by Andrei Korikov on 13.12.2021.
//

import Foundation

/// Create theme, that will be used to color cards and all other elements of UI.
struct Theme {
    var name: String
    var cardBackColorAssetName = "DefaultCardBack"
    var cardForeColorAssetName = "DefaultCardFore"
    var otherElementsColorAssetName = "DefaultElements"
    var emojis = [String]()
}
