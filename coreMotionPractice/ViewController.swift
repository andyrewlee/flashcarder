//
//  ViewController.swift
//  coreMotionPractice
//
//  Created by Jae Hoon Lee on 7/27/15.
//  Copyright © 2015 Jae Hoon Lee. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    var randomWord: String = ""
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    let dictionary = ["Abhor": "hate", "Bigot": "narrow-minded, prejudiced person", "Counterfeit": "fake; false",
                      "Enfranchise": "give voting rights", "Hamper": "hinder; obstruct", "Kindle": "to start a fire"]
    
    let motionManager = CMMotionManager()

    @IBAction func nextButtonPressed(sender: UIButton) {
        randomWord = dictionary.keys.array[Int(arc4random_uniform(UInt32(dictionary.keys.array.count)))]
        wordLabel.text = randomWord
    }
    
    @IBAction func startButtonPressed(sender: UIButton) {
        startButton.hidden = true
        nextButton.hidden = false
        if motionManager.deviceMotionAvailable {
            print("what")
            let mainQueue = NSOperationQueue.mainQueue()
            
            motionManager.startDeviceMotionUpdatesToQueue(mainQueue) {
                (motion, error) in
                
                let roll = motion!.attitude.roll
                
                
                if roll < -0.7 {
                    self.view.backgroundColor = UIColor.redColor()
                    print("show answer")
                    self.wordLabel.text = self.dictionary[self.randomWord]
                } else {
                    self.view.backgroundColor = UIColor.greenColor()
                    self.wordLabel.text = self.randomWord
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.hidden = true
    }
}

