//
//  CoreApi.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

protocol CoreApiProtocol {
    func performRequest(for url: CoreApiURL, completion: @escaping ((Data?, URLResponse?, Error?) -> Void))
}

class CoreApiLive: CoreApiProtocol {

    func performRequest(for url: CoreApiURL, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {

        var request = URLRequest(url: url.url())
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

class CoreApiMock: CoreApiProtocol {

    func performRequest(for url: CoreApiURL, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {

        let mockJson = fetchJsonForUrl(url)

        let data = mockJson.data(using: .utf8)
        completion(data, nil, nil)
    }

    private func fetchJsonForUrl(_ requestUrl: CoreApiURL) -> String {
        let bundle = Bundle(for: CoreApiMock.self)
        let filename = requestUrl.mockFileName()
        guard let path = bundle.path(forResource: filename, ofType: "json") else {
            fatalError("failed to load local resource: \(filename).json")
        }
        do {
            return try String(contentsOfFile: path)
        } catch let error {
            fatalError("failed to load json string from file: \(error)")
        }
    }
}
