//
//  CanvasView+DataBase.swift
//  DrawLinesDemo
//
//  Created by Shashikant's Mac on 9/13/19.
//  Copyright © 2019 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension for - Temp Line Handle
extension CanvasView {
    
    func didUpdateTempLine(strLineName: String, point: CGPoint) {
        DataBase.createTempLine(strLineName: strLineName, point: point)
    }
    
    
} //extension
