//
//  CanvasView.swift
//  DrawLinesDemo
//
//  Created by Shashikant's Mac on 9/13/19.
//  Copyright © 2019 redbytes. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    // MARK:- Outlets
    var intLineID = 0
    var lineWidth: CGFloat = 3.0
    var clrStroke = UIColor.lightGray.cgColor
    
    // MARK:- Variables
    fileprivate var linePoints = [[CGPoint]]() {
        didSet {
            intLineID = linePoints.count
        }
    }
    fileprivate var tempLine = [CGPoint]()
    
    // MARK:- ViewLifeCycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(clrStroke)
        context.setLineWidth(lineWidth)
        context.setLineCap(.round)
        
        linePoints.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        context.strokePath()
    }
    
    // MARK:- Gesture Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        intLineID += 1
        tempLine.removeAll()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        tempLine.append(point)
        updateDB()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        linePoints.append(tempLine)
        
    }

    // MARK:- Custom Methods
    func removeLastObjFromArr() {
        DispatchQueue.main.async {
            if !self.linePoints.isEmpty {
                self.linePoints.removeLast()
            }
            self.setNeedsDisplay()
        }
    }
    
    func removeAllObjFromArr() {
        DispatchQueue.main.async {
            self.linePoints.removeAll()
            self.setNeedsDisplay()
        }
    }
    
    func clearAll() {
        removeAllLines()
    }
    
    func undoLast() {
        removeSingleLine()
    }
    
    // MARK:- Redraw Lines as per points
    func redrawWithNewPoints(points: [[CGPoint]]) {
        DispatchQueue.main.async {
            self.linePoints = points
            self.setNeedsDisplay()
        }
    }
    
    func redrawWithNewPoints(points: [CGPoint]) {
        DispatchQueue.main.async {
            self.linePoints.append(points)
            self.setNeedsDisplay()
        }
    }
    
    func redrawWithNewPoints(point: CGPoint) {
        guard var lastPoint = linePoints.popLast() else {
            linePoints = [[point]]
            return
        }
        DispatchQueue.main.async {
            lastPoint.append(point)
            self.linePoints.append(lastPoint)
            self.setNeedsDisplay()
        }
    }
    
    // MARK:- DB Methods
    private func updateDB() {
        guard let lastPoints = linePoints.last else { return }
        DataBase.addNewLines(.Temp, "\(intLineID)", lastPoints) { (res) in
            switch res {
            case .success(_):
                break
            case .error(let strError):
                debugPrint(strError)
            }
        }
    }
    
    private func removeSingleLine() {
        guard !linePoints.isEmpty else { return }
        _ = linePoints.popLast()
        let newPoints = linePoints
        linePoints.removeAll()
        setNeedsDisplay()
        DataBase.addLines(.Point, newPoints) { (res) in
            switch res {
            case .success(_):
                break
            case .error(let strError):
                debugPrint(strError)
            }
        }
    }
    
    private func removeAllLines() {
        guard !linePoints.isEmpty else { return }
        DataBase.removeAllLine(.Point) { (res) in
            switch res {
            case .success(_):
                break
            case .error(let strError):
                debugPrint(strError)
            }
        }
    }
    
} // class
