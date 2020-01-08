//
//  String+localized.swift
//  Arch List PLay
//
//  Created by Andy Bell on 26.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
