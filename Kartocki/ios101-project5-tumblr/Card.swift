//
//  Card.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/5/23.
//

import Foundation
struct Card: Encodable, Decodable, Equatable {
    let front: String
    let back: String
    static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.front == rhs.front && lhs.back == rhs.back
        }
    
}

extension Card {
    func encodeToData() -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(self)
        } catch {
            print("Error encoding Card: \(error)")
            return nil
        }
    }

    static func decodeFromData(_ data: Data) -> Card? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Card.self, from: data)
        } catch {
            print("Error decoding Card: \(error)")
            return nil
        }
    }
}

// Storing and retrieving cards using UserDefaults
class CardManager {
    static let shared = CardManager()

    private let userDefaults = UserDefaults.standard
    private let key = "cards"

    func saveCards(cards: [Card]) {
        let encodedCards = cards.compactMap { $0.encodeToData() }
        userDefaults.set(encodedCards, forKey: key)
    }
    func deleteAllCards() {
            userDefaults.removeObject(forKey: key)
        }
    func loadCards() -> [Card] {
        guard let encodedCards = userDefaults.array(forKey: key) as? [Data] else {
            return []
        }

        return encodedCards.compactMap { Card.decodeFromData($0) }
    }
}
