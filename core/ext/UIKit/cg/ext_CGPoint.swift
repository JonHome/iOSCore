//
//  ext_CGPoint.swift
//  core
//
//  Created by Jon Home on 2020/4/30.
//  Copyright © 2020 JonHome. All rights reserved.
//

import Foundation
import UIKit


func -(l : CGPoint?, r: CGPoint) -> CGPoint? {
    guard let l = l else{
        return nil
    }
    
    let a = l - r
    return a
}

func *(l: CGPoint, r: CGFloat)-> CGPoint {
    return CGPoint(x: r * l.x, y: r * l.y)
}

func /(l: CGPoint, r: CGFloat)-> CGPoint {
    return CGPoint(x: l.x / r, y: l.y / r)
}


func -( l : CGPoint, r: CGPoint) -> CGPoint {
    return  CGPoint(x: l.x - r.x, y: l.y - r.y)
}

func +( l : CGPoint, r: CGPoint) -> CGPoint {
    return  CGPoint(x: l.x + r.x, y: l.y + r.y)
}


extension CGPoint {
    
    static func distanceBetween(_ point1:CGPoint, _ point2:CGPoint) -> CGFloat{
        return sqrt((point1.x - point2.x)*(point1.x - point2.x)+(point1.y - point2.y)*(point1.y - point2.y))
    }
    
}
