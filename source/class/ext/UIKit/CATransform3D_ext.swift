//
//  ext_CATransform3D.swift
//  core
//
//  Created by Jon Home on 2020/4/30.
//  Copyright © 2020 JonHome. All rights reserved.
//

import Foundation
import simd
import UIKit


extension CATransform3D {
    func decomposeTRS() -> (SIMD3<Float>, SIMD3<Float>, SIMD3<Float>) {
        let m0 = SIMD3<Float>(Float(self.m11), Float(self.m12), Float(self.m13))
        let m1 = SIMD3<Float>(Float(self.m21), Float(self.m22), Float(self.m23))
        let m2 = SIMD3<Float>(Float(self.m31), Float(self.m32), Float(self.m33))
        let m3 = SIMD3<Float>(Float(self.m41), Float(self.m42), Float(self.m43))

        let t = m3

        let sx = length(m0)
        let sy = length(m1)
        let sz = length(m2)
        let s = SIMD3<Float>(sx, sy, sz)

        let rx = m0 / sx
        let ry = m1 / sy
        let rz = m2 / sz

        let pitch = atan2(ry.z, rz.z)
        let yaw = atan2(-rx.z, hypot(ry.z, rz.z))
        let roll = atan2(rx.y, rx.x)
        let r = SIMD3<Float>(pitch, yaw, roll)

        return (t, r, s)
    }
}
