//
//  ImageReader.swift
//  core
//
//  Created by Jon Home on 2020/4/30.
//  Copyright © 2020 JonHome. All rights reserved.
//

import Foundation
import UIKit

class ImagePixelReader {

    enum Component:Int {
        case r = 0
        case g = 1
        case b = 2
        case alpha = 3
    }

    struct Color {
        var r:UInt8
        var g:UInt8
        var b:UInt8
        var a:UInt8

        var uiColor:UIColor {
            return UIColor(red:CGFloat(r)/255.0,
                           green:CGFloat(g)/255.0,
                           blue:CGFloat(b)/255.0,
                           alpha:CGFloat(a)/255.0)
        }

    }

    let image:UIImage
    private var data:CFData
    private let pointer:UnsafePointer<UInt8>
    private let scale:Int
    private let bytesPerPixel:Int
    private let bytesPerPixelBitStep: Int
    private let bitsPerComponent:Int

    init?(image:UIImage){

        self.image = image
        guard let cgImage = self.image.cgImage,
            let cfdata = cgImage.dataProvider?.data,
            let pointer = CFDataGetBytePtr(cfdata) else {
            return nil
        }
        self.bytesPerPixel = cgImage.bitsPerPixel / 8
        self.bytesPerPixelBitStep = (self.bytesPerPixel / 4)
        self.bitsPerComponent = cgImage.bitsPerComponent / 8
        self.scale = Int(image.scale)
        
        self.data = cfdata
        self.pointer = pointer
    }

    func at(x:Int, y:Int, component:Component)->UInt8{

        assert(CGFloat(x) < image.size.width)
        assert(CGFloat(y) < image.size.height)

        let pixelPosition = self.pixelPosition(x: x, y: y)
        let bytesPerPixelBitStep = self.bytesPerPixelBitStep

        return pointer[pixelPosition + component.rawValue * bytesPerPixelBitStep]
    }

    func at(x:Int, y:Int)->Color{

        assert(CGFloat(x) < image.size.width)
        assert(CGFloat(y) < image.size.height)

        let pixelPosition = self.pixelPosition(x: x, y: y)
        let bytesPerPixelBitStep = self.bytesPerPixelBitStep

        return Color(r: pointer[pixelPosition + Component.r.rawValue * bytesPerPixelBitStep],
                     g: pointer[pixelPosition + Component.g.rawValue * bytesPerPixelBitStep],
                     b: pointer[pixelPosition + Component.b.rawValue * bytesPerPixelBitStep],
                     a: pointer[pixelPosition + Component.alpha.rawValue * bytesPerPixelBitStep])
    }
    
    func pixelPosition(x:Int, y:Int) -> Int{
        let position = (Int(image.size.width) * y * scale + x) * bytesPerPixel * scale
        return position
    }
}

extension UIImage{
    var generateImagePixelReader: ImagePixelReader? {
        return ImagePixelReader.init(image: self)
    }
}
