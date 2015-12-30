//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Christella on 11/23/15.
//  Copyright © 2015 Christella. All rights reserved.
//

import UIKit
import AVFoundation // We imported this for audio (Audio-Video Framework)


class ViewController: UIViewController {
    
    //enum: short for enumeration. Like making your own type.
    //ex Operation type is an enum of type string
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    
    var btnSound: AVAudioPlayer!
    // '!' means that we are going to store something of type AVAudioPlayer in this button later but it is empty/unassigned now.
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    //currentOperation is of type Operation.
    //we initialized it to Operation.Empty when the app first loads
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        //In order to use the sound 'btn.wav' we need the path first
        //This is a const b/c the path is not going to change
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
       
        do {
        try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            //try incase there is a broke url. always put it in 'do' block before 'try' keyword
            //we assign the audio player of our button 'btnSound' here
            btnSound.prepareToPlay()
        }catch let err as NSError{ //if there is an error print it
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
        //when button gets tapped that button's tag gets added to the 
        //existing runningNumber and stored in runningNumber
        //the runningNumber is then displayed in the outputLbl
    }
    
//Name IBActions as events.
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
   
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
//Created function to follow the DRY Principle
    
    func processOperation(op: Operation){
        playSound() //we play sound when the green buttons are pressed too
        
        if currentOperation != Operation.Empty {
         
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    //performs the operation, converts it to a string and stores it in result
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            
            }
           
           
            currentOperation = op
            
        } else { //Runs if this is the first time an operator has been pressed
            
            leftValStr = runningNumber //whatever existing number exists gets stored here
            runningNumber = "" //we then clear out the running number
            currentOperation = op //we store the current operation as op, this functions parameter
            
            
            //The minute an operator gets pressed the current runningNumber gets stored in
            //leftValStr. runningNumber can now tore a new val
        }
    }
    
    
    
//Function to play the sound
    
    func playSound() {
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

