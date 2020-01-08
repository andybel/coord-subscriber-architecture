//
//  Comment.swift
//  Arch List PLay
//
//  Created by Andy Bell on 26.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
