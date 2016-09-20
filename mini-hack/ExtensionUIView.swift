//
//  ExtensionUIView.swift
//  sdasdasdasd
//
//  Created by Admin on 9/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
extension UIView{
    func cornerView(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func circleImage() {
        if self.frame.size.width == self.frame.size.height {
            cornerView(self.frame.size.width / 2)
        }
        
    }
}
