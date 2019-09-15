//
//  ViewController+SBProtocol.swift
//  DrawLine
//
//  Created by Shashikant Bhadke on 14/09/19.
//  Copyright © 2019 Shashikant Bhadke. All rights reserved.
//

import UIKit
import SBDropDown

// MARK :- Extensio For - SBTableProtocol
extension ViewController: SBTableProtocol {
    func configCellFor(currentIndex: Int, arrSelectedIndex: [Int], currentData: Any, cell: SBTableCell, key: Any?) {
        cell.imgSelected = #imageLiteral(resourceName: "correct")
        if arrColor.count > currentIndex {
            cell.lblTitle.backgroundColor = arrColor[currentIndex]
        }
        cell.isSelected(arrSelectedIndex.contains(currentIndex))
    }
    
    func btnSelectSBProtocolPressed(arrSelectedIndex: [Int], arrElements: [Any], key: Any?) {
        if let currentIndex = arrSelectedIndex.first, arrColor.count > currentIndex {
            viewBoard.clrStroke = arrColor[currentIndex]
        }
    }
} //extension
