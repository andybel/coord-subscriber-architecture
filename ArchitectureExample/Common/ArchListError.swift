//
//  ArchListError.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

public enum ArchListError: Error {
    case decodingError
    case general(String)
}

extension ArchListError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("decoding_error", comment: "")
        case .general(let desc):
            return desc
        }
    }
}
