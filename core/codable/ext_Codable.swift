//
//  ext_Codable.swift
//  core
//
//  Created by Jon Home on 2018/12/25.
//  Copyright © 2018 homebit. All rights reserved.
//

import Foundation


extension Encodable{
    public func makeJsonObject() throws -> Any {
        let data = try JSONEncoder.init().encode(self)
        let any = try JSONSerialization.jsonObject(with: data, options: [])
        return any
    }
}
