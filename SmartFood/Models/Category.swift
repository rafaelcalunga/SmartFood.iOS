//
//  Category.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import Foundation

struct Category: Identifiable, Codable, Hashable {
    let id: UUID?
    let name: String
}
