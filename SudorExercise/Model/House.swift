//
//  House.swift
//  SudorExercise
//

import Foundation

// MARK: - House
struct House: Codable {
    let url: String
    let name, region, coatOfArms, words: String
    let currentLord, heir, overlord: String
    let founded, founder, diedOut: String
}
