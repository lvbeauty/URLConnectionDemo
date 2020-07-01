//
//  DataModel.swift
//  Tong_URLConnection
//
//  Created by Tong Yi on 5/18/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import Foundation

struct Item: Decodable
{
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
