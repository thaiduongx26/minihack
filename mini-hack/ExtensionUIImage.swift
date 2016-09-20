//
//  ExtensionUIImage.swift
//  mini-hack
//
//  Created by Admin on 9/19/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

extension UIImage{
    static func processPixelsInImage(inputImage: UIImage) -> UIImage? {
        let inputCGImage     = inputImage.CGImage
        let colorSpace       = CGColorSpaceCreateDeviceRGB()
        let width            = CGImageGetWidth(inputCGImage)
        let height           = CGImageGetHeight(inputCGImage)
        let bytesPerPixel    = 4
        let bitsPerComponent = 8
        let bytesPerRow      = bytesPerPixel * width
        let bitmapInfo       = Equatable.bitmapInfo
        
        guard let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo) else {
            print("unable to create context")
            return nil
        }
        
        CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), inputCGImage)
        
        let pixelBuffer = UnsafeMutablePointer<Equatable>(CGBitmapContextGetData(context))
        
        var currentPixel = pixelBuffer
        
        let white = Equatable(red: 0, green: 0, blue: 0, alpha: 0)
        let black = Equatable(red: 0, green: 0, blue: 0, alpha: 255)
        
        for _ in 0 ..< Int(height) {
            for _ in 0 ..< Int(width) {
                if currentPixel.memory.red != white.red && currentPixel.memory.alpha != white.alpha && currentPixel.memory.blue != white.blue && currentPixel.memory.green != white.green{
                    currentPixel.memory = black
                }
                currentPixel += 1
            }
        }
        
        let outputCGImage = CGBitmapContextCreateImage(context)
        let outputImage = UIImage(CGImage: outputCGImage!, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        
        return outputImage
    }
    
    struct Equatable {
        var color: UInt32
        
        var red: UInt8 {
            return UInt8((color >> 24) & 255)
        }
        
        var green: UInt8 {
            return UInt8((color >> 16) & 255)
        }
        
        var blue: UInt8 {
            return UInt8((color >> 8) & 255)
        }
        
        var alpha: UInt8 {
            return UInt8((color >> 0) & 255)
        }
        
        init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
            color = (UInt32(red) << 24) | (UInt32(green) << 16) | (UInt32(blue) << 8) | (UInt32(alpha) << 0)
        }
        
        static let bitmapInfo = CGImageAlphaInfo.PremultipliedLast.rawValue | CGBitmapInfo.ByteOrder32Little.rawValue
        

    }
    
    
}
