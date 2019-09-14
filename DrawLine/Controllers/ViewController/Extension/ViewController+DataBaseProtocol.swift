//
//  ViewController+DataBaseProtocol.swift
//  DrawLinesDemo
//
//  Created by Shashikant's Mac on 9/13/19.
//  Copyright © 2019 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension for - DataBaseProtocol
extension ViewController: DataBaseProtocol {
    func getNewAddedLineDelegate(_ arrPoints: Any?, _ strError: String?) {
        getMultiplesLines(arrPoints: arrPoints)
        getSingleLines(arrPoints: arrPoints)
        getSinglePoint(arrPoints: arrPoints)
    }
    
    func getChangedLineDelegate(_ arrPoints: Any?, _ strError: String?) {
        getMultiplesLines(arrPoints: arrPoints)
        getSingleLines(arrPoints: arrPoints)
        getSinglePoint(arrPoints: arrPoints)
    }
    
    func getRemovedLineDelegate(_ arrPoints: Any?, _ strError: String?) {
        debugPrint("------------ getRemovedLineDelegate ------------")
        getMultiplesLines(arrPoints: arrPoints, true)
        getSingleLines(arrPoints: arrPoints, true)
        getSinglePoint(arrPoints: arrPoints, true)
    }
} //extension

// MARK:- Extension for -
extension ViewController {
    private func getMultiplesLines(arrPoints: Any?,_ isRemove: Bool = false) {
        var arrCGPoints = [[CGPoint]]()
        guard let arrArrDic = arrPoints as? [[[String: Any]]] else { return }
        if isRemove {
            viewBoard.removeAllObjFromArr()
        } else {
            arrArrDic.forEach { (arrDic) in
                var arrCGPoint = [CGPoint]()
                arrDic.forEach({ (dic) in
                    if let x = dic["x"] as? Double, let y = dic["y"] as? Double {
                        arrCGPoint.append(CGPoint(x: x, y: y))
                    }
                })
                arrCGPoints.append(arrCGPoint)
            }
        }
        viewBoard.redrawWithNewPoints(points: arrCGPoints)
    }
    
    private func getSingleLines(arrPoints: Any?,_ isRemove: Bool = false) {
        var arrCGPoints = [CGPoint]()
        guard let arrArrDic = arrPoints as? [[String: Any]] else { return }
        if isRemove {
            viewBoard.removeLastObjFromArr()
        } else {
            arrArrDic.forEach({ (dic) in
                if let x = dic["x"] as? Double, let y = dic["y"] as? Double {
                    arrCGPoints.append(CGPoint(x: x, y: y))
                }
            })
        }
        viewBoard.redrawWithNewPoints(points: arrCGPoints)
    }
    
    private func getSinglePoint(arrPoints: Any?,_ isRemove: Bool = false) {
        guard let dic = arrPoints as? [String: Any] else { return }
        if isRemove {
            
        } else {
            if let x = dic["x"] as? Double, let y = dic["y"] as? Double {
                let point = CGPoint(x: x, y: y)
                viewBoard.redrawWithNewPoints(point: point)
            }
        }
    }
} //extension
