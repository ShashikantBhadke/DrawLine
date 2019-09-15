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
    var clrStroke = UIColor.lightGray
    
    // MARK:- Variables
    fileprivate var linePoints = [LineModel]()
    
    // MARK:- ViewLifeCycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineCap(.round)
        
        linePoints.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.width)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    // MARK:- Gesture Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let strLineName = Date().currentTimeStamp()
        linePoints.append(LineModel(strName: strLineName, color: clrStroke, width: lineWidth, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard var lastPoints = linePoints.popLast(), let point = touches.first?.location(in: nil) else { return }
        lastPoints.points.append(point)
        linePoints.append(lastPoints)
        setNeedsDisplay()
    }
    
    // MARK:- Custom Methods
    func clearAll() {
        linePoints.removeAll()
        setNeedsDisplay()
    }
    
    func undoLast() {
        _ = linePoints.popLast()
        setNeedsDisplay()
    }
} // class

extension Date {
    func currentTimeStamp() -> String {
        return String(self.timeIntervalSince1970 * 1000)
    }
}
