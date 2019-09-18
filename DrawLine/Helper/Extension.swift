//
//  Extension.swift
//  DrawLine
//
//  Created by Shashikant's Mac on 9/18/19.
//  Copyright © 2019 Shashikant Bhadke. All rights reserved.
//

import UIKit

// MARK:- Extension for - UIColor
extension UIColor {
    /// Get random color
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
} //extension
