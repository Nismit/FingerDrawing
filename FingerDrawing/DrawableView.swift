//
//  DrawableView.swift
//  FingerDrawing
//
//  Created by Michinobu Nishimoto on 2017-06-03.
//  Copyright © 2017 Michinobu Nishimoto. All rights reserved.
//

import UIKit

class DrawableView: UIView, UITextFieldDelegate {
    
    struct DrawableViewSetting {
        var lineColor: CGColor = UIColor.red.cgColor
        var lineWidth: CGFloat = 8
    }
    
    var currentLine: Line? = nil
    private var currentImage: UIImage? = nil
    private var clearMode: Bool = false
    private var textMode: Bool = false
    private var textViewTag: Int = 0
    var currentSetting = DrawableViewSetting()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Log: Execute touchbegin()")
        let point = touches.first!.location(in: self)
        //print("X-Point: \(point.x)")
        //print("Y-Point: \(point.y)")
        
        if (clearMode == true) {
            currentLine = Line(color: self.currentSetting.lineColor, width: self.currentSetting.lineWidth, eraser: true)
            currentLine?.points.append(point)
        } else if (textMode == true) {
            makeTextField(point: point)
        } else {
            currentLine = Line(color: self.currentSetting.lineColor, width: self.currentSetting.lineWidth, eraser: false)
            currentLine?.points.append(point)
        }
        
        self.setNeedsDisplay()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Log: Execute touchmoved()")
        let point = touches.first!.location(in: self)
        currentLine?.points.append(point)
        self.setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Log: Execute touchend()")
        if let line = currentLine {
            if line.points.count > 1 {
                //parts.append(currentLine!)
            } else {
                //self.parts.append(Dot(line: currentLine!))
            }
        }
        
        currentLine = nil
    }
    
    override func draw(_ rect: CGRect) {
        //print("Log: Execute draw()")
        //delegate?.onUpdateDrawableView()
        
        let _ = UIGraphicsGetImageFromCurrentImageContext()
        
        updateCurrentImage()
        self.currentImage?.draw(in: self.bounds)
    }
    
    private func requireRedraw() {
        self.currentImage = nil
        self.setNeedsDisplay()
    }
    
    private func makeTextField(point: CGPoint) {
        //print("Log: Execute makeTextField()")
        let textField = UITextField(frame: CGRect(x: point.x, y: point.y, width: self.frame.width * 2 / 3, height: 48))
        
        textField.placeholder = "Input Something"
        
        textField.tag = textViewTag
        textViewTag += 1
        
        textField.delegate = self
        textField.returnKeyType = .done
        self.addSubview(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Should return")
        textField.resignFirstResponder()
        
        if (textField.text?.isEmpty)! {
            print("View Tag: \(textField.tag)")
            let willBeDeletedView = self.subviews[textField.tag]
            willBeDeletedView.removeFromSuperview()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Start")
        if textField.isEditing {
            textField.becomeFirstResponder()
        }
        
        return true
    }
    
    func clear() {
        //self.parts = []
        self.currentLine = nil
        self.requireRedraw()
    }
    
    func toggleEraser() {
        clearMode = !clearMode
    }
    
    func toggleText() {
        textMode = !textMode
    }
    
    func updateCurrentImage() {
        //print("Log: Execute updateCurrentImage()")
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        let imageContext = UIGraphicsGetCurrentContext()
        // Get previous view and draw
        self.getCurrentImage().draw(in: self.bounds)
        
        // Add flash view
        if let line = currentLine {
            line.drawLastlineOnContext(context: imageContext!)
        }

        // Refresh
        self.currentImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func getCurrentImage() -> UIImage {
        //print("Log: getCurrentImage()")
        if self.currentImage == nil {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
            let context = UIGraphicsGetCurrentContext()
            //parts.forEach{$0.drawOnContext(context!)}
            currentLine?.drawOnContext(context: context!)
            self.currentImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return self.currentImage!
    }

}
