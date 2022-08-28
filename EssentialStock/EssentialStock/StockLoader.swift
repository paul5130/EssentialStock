//
//  StockLoader.swift
//  EssentialStock
//
//  Created by Paul Wen on 2022/8/28.
//

import Foundation

public typealias LoadStockResult = (Result<[StockItem],Error>)

public protocol StockLoader{
    func load(completion: @escaping(LoadStockResult) -> Void)
}
