//
//  StockItem.swift
//  EssentialStock
//
//  Created by Paul Wen on 2022/8/28.
//

import Foundation

public struct StockItem: Equatable{
    let date: String
    let high: String
    let low: String
    let open: String
    let close: String
    let diff: String
    let volume: String
    
    public init(date: String, high: String, low: String, open: String, close: String, diff: String, volume: String) {
        self.date = date
        self.high = high
        self.low = low
        self.open = open
        self.close = close
        self.diff = diff
        self.volume = volume
    }
}
