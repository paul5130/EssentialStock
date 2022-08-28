//
//  RemoteStockLoaderTest.swift
//  EssentialStockTests
//
//  Created by Paul Wen on 2022/8/28.
//

import XCTest
import EssentialStock


class RemoteStockLoaderTests: XCTestCase{
    func test_init_doesNotRequestDataFromURL(){
        let (_,client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    func test_load_requestDataFromURL(){
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load { _ in }
        XCTAssertEqual(client.requestedURLs, [url])
    }
    func test_loadTwice_requestsDataFromURLTwice(){
        let url = URL(string: "https://a-given-url.com")!
        let (sut,client) = makeSUT(url: url)
        sut.load { _ in }
        sut.load { _ in }
        XCTAssertEqual(client.requestedURLs, [url,url])
    }
    // 測試傳遞錯誤的值會回應正確的錯誤資訊
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        var capturedErrors = [RemoteStockLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    // 回傳status code有被抓到
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            var capturedErrors = [RemoteStockLoader.Error]()
            sut.load { capturedErrors.append($0) }
            
            client.complete(withStatusCode: code, at: index)
            
            XCTAssertEqual(capturedErrors, [.invalidData])
        }
    }
    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteStockLoader, client: HTTPClientSpy){
        let client = HTTPClientSpy()
        let sut = RemoteStockLoader(url: url, client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient{
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping ((HTTPClientResult) -> Void)) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            messages[index].completion(.success(response))
        }
    }
}
