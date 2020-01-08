//
//  CoreDecoder.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

class CoreDecoder {

    static func decodeFrom<T: Decodable>(data: Data?, completion: @escaping  ((_: Result<T>) -> Void)) {

        guard let decodeData = data else {
            completion(.failure(ArchListError.decodingError))
            return
        }

        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: decodeData)
            completion(.success(decoded))
        } catch let err {
            completion(.failure(err))
        }
    }
}
