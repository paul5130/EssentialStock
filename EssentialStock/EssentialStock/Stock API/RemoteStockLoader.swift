//
//  RemoteStockLoader.swift
//  EssentialStock
//
//  Created by Paul Wen on 2022/8/28.
//

import Foundation

public class RemoteFeedLoader{
    let client: HTTPClient
    let url: URL
    public init(url: URL,client: HTTPClient){
        self.url = url
        self.client = client
    }
    public func load(){
        client.get(from: url)
    }
}

public protocol HTTPClient{
    func get(from url: URL)
}
