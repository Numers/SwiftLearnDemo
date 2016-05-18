//
//  FirstViewController.swift
//  SwiftLearnDemo
//
//  Created by baolicheng on 15/12/8.
//  Copyright © 2015年 RenRenFenQi. All rights reserved.
//

import UIKit
class FirstViewController: UIViewController {
    @IBOutlet weak var lblDisplay: UILabel!
    var useInMiddle = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton){
        let digit = sender.currentTitle!
        if useInMiddle
        {
            lblDisplay.text = lblDisplay.text! + digit
        }else{
            lblDisplay.text =  digit
            useInMiddle = true
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        if useInMiddle {
            enter()
        }
        
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }
    
    func performOperation(operation:(Double,Double)->Double){
        if stack.count >= 2
        {
            displayValue = operation(stack.removeLast(),stack.removeLast())
            enter()
        }
    }
    var stack = Array<Double>()
    @IBAction func enter() {
        useInMiddle = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    var displayValue:Double{
        get{
            var number:NSNumber?
            number = NSNumberFormatter().numberFromString(lblDisplay.text!)
            return number!.doubleValue
        }
        set{
            lblDisplay.text = "\(newValue)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "panGesture:"))
        
        self.view.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: "pinchGesture:"))
    }
    
    func panGesture(gesture:UIPanGestureRecognizer)
    {
        switch gesture.state{
        case .Changed:
            print(gesture.translationInView(self.view).y)
//            gesture.setTranslation(CGPointZero, inView: self.view)
            break
        default:
            break
        }
    }
    
    func pinchGesture(gesture:UIPinchGestureRecognizer)
    {
        switch gesture.state{
        case .Changed:
            print(gesture.scale)
//            gesture.scale = 1
            //            gesture.setTranslation(CGPointZero, inView: self.view)
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

