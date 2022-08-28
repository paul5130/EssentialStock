//
//  RemoteStockLoaderTest.swift
//  EssentialStockTests
//
//  Created by Paul Wen on 2022/8/28.
//

import XCTest

class RemoteFeedLoader{
    
}

class HTTPClient{
    var requestedURL: URL?
}

class RemoteStockLoaderTests: XCTestCase{
    func test_init_doesNotRequestDataFromURL(){
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
}
