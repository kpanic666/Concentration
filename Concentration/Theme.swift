//
//  Theme.swift
//  Concentration
//
//  Created by Andrei Korikov on 13.12.2021.
//

import Foundation

/// Create theme, that will be used to color cards and all other elements of UI.
/// - Parameters: color parameters have default values. Otherwise they must contain Color Set name.
struct Theme {
    var name: String
    var cardBackColorAssetName = "DefaultCardBack"
    var cardForeColorAssetName = "DefaultCardFore"
    var otherElementsColorAssetName = "DefaultElements"
    var backgroundColorAssetName = "DefaultBack"
    var emojis = [String]()
}

class ThemeManager {
    static let main = ThemeManager()
    private var themes = [Theme]()
    
    private init() {
        themes.append(Theme(
            name: "Halloween",
            emojis: ["🦇", "😱", "🙀", "😈", "👻", "🎃", "🍭", "🍬"]))
        themes.append(Theme(
            name: "Winter",
            cardBackColorAssetName: "WinterCardBack",
            cardForeColorAssetName: "WinterCardFore",
            otherElementsColorAssetName: "WinterElements",
            backgroundColorAssetName: "WinterBack",
            emojis: ["🥶", "❄️", "⛷", "☃️", "🌨", "🧣", "⛸", "🎅🏻"]))
        themes.append(Theme(
            name: "Sport",
            cardBackColorAssetName: "SportCardBack",
            cardForeColorAssetName: "SportCardFore",
            otherElementsColorAssetName: "SportElements",
            backgroundColorAssetName: "SportBack",
            emojis: ["⚽️", "🎳", "🥊", "🏓", "🥏", "🥋", "🥌", "⛳️"]))
        themes.append(Theme(
            name: "Animals",
            cardBackColorAssetName: "AnimalsCardBack",
            cardForeColorAssetName: "AnimalsCardFore",
            otherElementsColorAssetName: "AnimalsElements",
            backgroundColorAssetName: "AnimalsBack",
            emojis: ["🐱", "🐭", "🐍", "🐑", "🐸", "🐥", "🐳", "🐵"]))
        themes.append(Theme(
            name: "Faces",
            cardBackColorAssetName: "FacesCardBack",
            cardForeColorAssetName: "FacesCardFore",
            otherElementsColorAssetName: "FacesElements",
            backgroundColorAssetName: "FacesBack",
            emojis: ["😀", "😍", "🤩", "😎", "😡", "🤭", "😰", "🤢"]))
        themes.append(Theme(
            name: "Business",
            cardBackColorAssetName: "BusinessCardBack",
            cardForeColorAssetName: "BusinessCardFore",
            otherElementsColorAssetName: "BusinessElements",
            backgroundColorAssetName: "BusinessBack",
            emojis: ["👩🏻‍💼", "📐", "🗄", "📅", "📊", "📎", "📌", "📈"]))
    }
    
    func getRandomTheme() -> Theme {
        themes.randomElement() ?? Theme(name: "Unknown")
    }
    
    func addNew(theme: Theme) {
        themes.append(theme)
    }
}
