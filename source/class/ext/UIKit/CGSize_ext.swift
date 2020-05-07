//
//  ext_CG.swift
//  core
//
//  Created by Jon Home on 2020/2/10.
//  Copyright © 2020 JonHome All rights reserved.
//

import Foundation
import UIKit


public func *(l: CGSize, r: CGFloat)-> CGSize {
    return CGSize(width: r * l.width, height: r * l.height)
}

public func *(l: CGSize,r: CGSize)-> CGSize{
    return CGSize(width: l.width * r.width, height: l.height*r.height)
}


public func *(l: CGSize?, r: CGSize)-> CGSize? {
    guard let l = l else{
        return nil
    }
    
    let a = l * r
    return a
}

public func *(l: CGSize?, r: CGFloat)-> CGSize? {
    guard let l = l else{
        return nil
    }
    let a = l * r
    return a
}

public func /( l : CGSize, r: CGSize) -> CGSize {
    return CGSize(width:l.width / r.width,height: l.height / r.height)
}

public func /( l : CGSize, r: CGFloat) -> CGSize {
    return CGSize(width:l.width / r, height: l.height / r)
}

public func /( l: CGSize?, r: CGSize) -> CGSize? {
    guard let l = l else{
        return nil
    }
    
    let a = l / r
    return a
}

public func +( l : CGSize, r: CGFloat) -> CGSize {
    return CGSize(width:l.width + r, height: l.height + r)
}

public func +( l : CGSize, r: CGSize) -> CGSize {
    return CGSize(width:l.width + r.width,height: l.height + r.height)
}

public func -( l : CGSize, r: CGSize) -> CGSize {
    return CGSize(width:l.width - r.width,height: l.height - r.height)
}


public func -( l : CGSize, r: CGFloat) -> CGSize {
    return CGSize(width:l.width - r, height: l.height - r)
}

public func -(l : CGSize?, r: CGFloat) -> CGSize? {
    guard let l = l else{
        return nil
    }
    
    let a = l - r
    return a
}

public func -(l : CGSize?, r: CGSize) -> CGSize? {
    guard let l = l else{
        return nil
    }
    
    let a = l - r
    return a
}



extension CGSize {
    public var point: CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
    
    public var bounds: CGRect {
        return CGRect.init(origin: .zero, size: self)
    }
    
    public var minLength: CGFloat{
        return min(self.width, self.height)
    }
    
    public var maxLength: CGFloat{
        return max(self.width, self.height)
    }
}
