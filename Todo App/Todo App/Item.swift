//
//  Item.swift
//  Todo App
//
//  Created by Milan Rathod on 24/11/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
