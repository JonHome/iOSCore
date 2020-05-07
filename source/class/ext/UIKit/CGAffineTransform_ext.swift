//
//  ext_CGAffineTransform.swift
//  core
//
//  Created by Jon Home on 2020/4/30.
//  Copyright © 2020 JonHome. All rights reserved.
//

import Foundation
import UIKit

extension CGAffineTransform {
    public var xscale: CGFloat  {
        let t = self;
        return sqrt(t.a * t.a + t.c * t.c);
    }
    public var yscale: CGFloat  {
        let t = self;
        return sqrt(t.b * t.b + t.d * t.d);
    }
    
    public var mixScale: CGFloat  {
        let t = self;
        return sqrt(t.xscale * t.xscale + t.yscale * t.yscale);
    }
    
    public var rotation: CGFloat { return CGFloat(atan2(Double(self.b), Double(self.a))) }

}
