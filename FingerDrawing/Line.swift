//
//  Line.swift
//  FingerDrawing
//
//  Created by Michinobu Nishimoto on 2017-06-03.
//  Copyright © 2017 Michinobu Nishimoto. All rights reserved.
//

import UIKit

class Line {
    var points: [CGPoint]
    var color: CGColor
    var width: CGFloat
    var eraser: Bool = false
    
    init(color: CGColor, width: CGFloat, eraser: Bool){
        self.color = color
        self.width = width
        self.eraser = eraser
        self.points = []
    }
    
    func drawOnContext(context: CGContext){
        UIGraphicsPushContext(context)
        
        if (eraser == true) {
            context.setBlendMode(.clear)
        } else {
           context.setStrokeColor(self.color)
        }
        context.setLineWidth(self.width)
        context.setLineCap(CGLineCap.round)
        
        // points
        if self.points.count > 1 {
            context.move(to: CGPoint(x: points.first!.x, y: points.first!.y))
            for (_, point) in self.points.dropFirst().enumerated() {
                context.addLine(to: CGPoint(x: point.x, y: point.y))
            }
        } else {
            //Dot(line: self).drawOnContext(context)
        }
        context.strokePath()
        
        UIGraphicsPopContext()
    }
    
    // refresh view just wrote sth
    func drawLastlineOnContext(context: CGContext) {
        if self.points.count > 1 {
            UIGraphicsPushContext(context)
            
            if (eraser == true) {
                context.setBlendMode(.clear)
            } else {
                context.setStrokeColor(self.color)
            }
            context.setLineWidth(self.width)
            context.setLineCap(CGLineCap.round)
            
            let startPoint = self.points[self.points.endIndex-2]
            let endPoint = self.points.last!
            context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
            context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                
            context.strokePath()
            UIGraphicsPopContext()
        } else if !self.points.isEmpty {
            //Dot(line: self).drawOnContext(context)
        }
    }
}
