//
//  ext_CGRect.swift
//  core
//
//  Created by Jon Home on 2020/4/30.
//  Copyright © 2020 homebit. All rights reserved.
//

import Foundation
import UIKit


func +( l : CGRect, r: CGPoint) -> CGRect {
    return CGRect.init(origin: l.origin + r, size: l.size)
}

func +( l : CGRect, r: CGSize) -> CGRect {
    return CGRect.init(origin: l.origin, size: l.size + r)
}

func +( l : CGRect, r: CGRect) -> CGRect {
    return CGRect.init(origin: l.origin + r.origin, size: l.size + r.size)
}
