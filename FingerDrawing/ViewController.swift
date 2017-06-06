//
//  ViewController.swift
//  FingerDrawing
//
//  Created by Michinobu Nishimoto on 2017-06-03.
//  Copyright © 2017 Michinobu Nishimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var drawableView: DrawableView!
    @IBOutlet weak var smallStroke: UIButton!
    @IBOutlet weak var middleStroke: UIButton!
    @IBOutlet weak var largeStroke: UIButton!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonSetting() {
        smallStroke.layer.borderWidth = 1
        smallStroke.layer.borderColor = UIColor.black.cgColor
        middleStroke.layer.borderWidth = 1
        middleStroke.layer.borderColor = UIColor.black.cgColor
        largeStroke.layer.borderWidth = 1
        largeStroke.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func changeSmallStroke() {
        drawableView.currentSetting.lineWidth = 3
        smallStroke.backgroundColor = UIColor.black
        middleStroke.backgroundColor = UIColor.white
        largeStroke.backgroundColor = UIColor.white
    }
    
    @IBAction func changeMediumStroke() {
        drawableView.currentSetting.lineWidth = 8
        smallStroke.backgroundColor = UIColor.white
        middleStroke.backgroundColor = UIColor.black
        largeStroke.backgroundColor = UIColor.white
    }
    
    @IBAction func changeLargeStroke() {
        drawableView.currentSetting.lineWidth = 15
        smallStroke.backgroundColor = UIColor.white
        middleStroke.backgroundColor = UIColor.white
        largeStroke.backgroundColor = UIColor.black
    }
    
    @IBAction func changeText() {
        drawableView.toggleText()
    }
    
    @IBAction func changeMode() {
        drawableView.toggleEraser()
    }
    
    @IBAction func clearCanvas() {
        drawableView.clear()
    }

}

