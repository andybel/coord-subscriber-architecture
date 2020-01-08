//
//  Aricle.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

struct Article: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
