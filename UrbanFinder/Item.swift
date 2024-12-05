//
//  Item.swift
//  UrbanFinder
//
//  Created by Juan Delgado Lasso on 5/12/24.
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
