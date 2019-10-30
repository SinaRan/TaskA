//
//  UIVIewExtensions.swift
//  TaskA
//
//  Created by Sina on 10/30/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

private var assocKey : UInt8 = 0
extension UIView {
    var indexPath:IndexPath{
        get {
            return objc_getAssociatedObject(self, &assocKey) as! IndexPath
        }
        set(newValue){
            objc_setAssociatedObject(self, &assocKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
