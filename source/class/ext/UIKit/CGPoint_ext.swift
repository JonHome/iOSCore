//
//  ext_CGPoint.swift
//  core
//
//  Created by Jon Home on 2020/4/30.
//  Copyright © 2020 JonHome. All rights reserved.
//

import Foundation
import UIKit



public func *(l: CGPoint, r: CGFloat)-> CGPoint {
    return CGPoint(x: r * l.x, y: r * l.y)
}

public func /(l: CGPoint, r: CGFloat)-> CGPoint {
    return CGPoint(x: l.x / r, y: l.y / r)
}

public func -(l : CGPoint?, r: CGPoint) -> CGPoint? {
    guard let l = l else{
        return nil
    }
    
    let a = l - r
    return a
}

public func -( l : CGPoint, r: CGPoint) -> CGPoint {
    return  CGPoint(x: l.x - r.x, y: l.y - r.y)
}

public func +( l : CGPoint, r: CGPoint) -> CGPoint {
    return  CGPoint(x: l.x + r.x, y: l.y + r.y)
}


extension CGPoint {
    
    public static func distanceBetween(_ point1:CGPoint, _ point2:CGPoint) -> CGFloat{
        return sqrt((point1.x - point2.x)*(point1.x - point2.x)+(point1.y - point2.y)*(point1.y - point2.y))
    }
    
    public var size: CGSize {
        return CGSize(width: x, height: y)
    }
    
}
